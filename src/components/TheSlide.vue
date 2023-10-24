<template>
    <div class="slide">
        <h1>{{ slide.title }}</h1>
        <ul class="points">
            <li v-for="point in $props.slide.points" :key="point">
                {{ point }}
            </li>
        </ul>
        <p>{{ slide.body }}</p>

        <div v-if="$props.slide.img" class="image" v-html="JSON.parse(slide.img)"></div>
        <pre v-if="$props.slide.code">
            <code>{{ decodedCode }}</code>
        </pre>
    </div>
</template>

<script lang="ts">
import type { PropType } from 'vue';

export default {
    props: {
        slide: {
            type: Object as PropType<SlideType>,
            required: true
        }
    },
    computed: {
        decodedCode() {
            return JSON.parse(JSON.stringify(this.$props.slide.code)).replace(/\\\\n/g, "\n").replace(/\\t/g, "\t").replace(/\\"/g, "\"")
        }
    }
}

export interface SlideType {
    title: string;
    points: [string];
    code: string;
    body: string;
    img: string;
}
</script>

<style scoped>
h1 {
    font-size: xxx-large;
}

li {
    font-size: xx-large;
}

pre {
    white-space: pre;
}

.image {
    position: relative;
    max-width: 100%
}

pre {
    padding: 2em;
    white-space: pre-wrap;
    font-family: monospace;
    backdrop-filter: contrast(0.5);
    border-radius: 5px;
}

.slide {
    margin-bottom: 2em;
}
</style>