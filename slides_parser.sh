#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_file.md> <output_file.json>"
  exit 1
fi

# Assign the input and output file paths
input_file="$1"
output_file="$2"

# Initialize variables
slide_title=""
slide_points=()
slide_code=""
slide_body=""
slide_img=""
in_code_block=false
slides=()

append_slide() {
    slide_points_json=$(printf '%s\n' "${slide_points[@]}" | jq -R . | jq -s '.')

    # Escape special characters in slide title, body, and code using jq
    slide_title_json=$(jq -n --arg title "$slide_title" '$title')
    slide_body_json=$(jq -n --arg body "$slide_body" '$body')
    #slide_code_json=$(echo "$slide_code" | jq -R '@sh')
    slide_code_json=$(jq -n --arg code "$slide_code" '$code')

    slide_img_json=$(jq -n --arg img "$slide_img" '$img')

    points_array="[]"

    for point in "${slide_points[@]}"; do
        # Escape special characters in the point using jq
        point_json=$(jq -n --arg point "$point" '$point')

        # Append the point to the points array
        points_array=$(jq --argjson point "$point_json" \
            '. += [$point]' <<< "$points_array")
    done

    # Remove the extra quotes around slide_title using jq string interpolation
    slide_title_json="${slide_title_json%\"}"
    slide_title_json="${slide_title_json#\"}"

    # Remove the extra quotes around slide_body using jq string interpolation
    slide_body_json="${slide_body_json%\"}"
    slide_body_json="${slide_body_json#\"}"

    # Remove the extra quotes around slide_body using jq string interpolation
    slide_code_json="${slide_code_json%\"}"
    slide_code_json="${slide_code_json#\"}"

    json=$(jq -n \
        --arg title "$slide_title_json" \
        --arg body "$slide_body_json" \
        --arg img "$slide_img_json" \
        --argjson points "$points_array" \
        --arg code "$slide_code_json" \
        '{ "title": $title, "body": $body, "points": $points, "img": $img, "code": $code }')

    slides+=("$json")

    # Reset variables
    unset slide_points slide_code slide_body slide_img
}

while IFS= read -r line
do
    if [ -z "$line" ]; then
        continue
    fi

    if [[ $line == \#* && $slide_title != "" ]]; then
        append_slide
    fi

    if [[ $line == \#* ]] ; then
        slide_title="${line#*\# }"

    elif [[ $line == \-* ]]; then
        line_point="${line#*- }"
        slide_points+=("$line_point")
    
    elif [[ $line == \<img*src* ]]; then
        slide_img=$line

    elif [[ $line == "\```"* ]]; then
        if [[ $in_code_block == false ]]; then
            in_code_block=true
        else
            in_code_block=false
            slide_code+="\n"
        fi
    else

        if [[ $in_code_block == true ]]; then
            slide_code+="$line\n"
            continue
        else
            slide_body+="$line"
        fi
    fi
done < "$input_file"

# adds the last slide
append_slide

slides_json=$(IFS=,; echo "[${slides[*]}]")

echo "$slides_json" > "$output_file"
