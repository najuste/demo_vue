<template>
    <div class="progress">
        <input type="number" v-model="progress.currentIndex" :min="progress.minIndex" :max="progress.maxIndex"
            @input="updateCurrentIndex">
        <div class="fill" :style="{ width: `${progressState}%` }"></div>
        <div class="background"></div>
    </div>
</template>

<script lang="ts">
import { type PropType } from 'vue';



export default {
    inject: ['progressBarProps2'],
    props: {
        progress: {
            type: Object as PropType<ProgressBarType>,
            required: true,
        }
    },
    computed: {
        progressState() {
            const { currentIndex, maxIndex } = this.progress;
            return currentIndex < maxIndex ? (this, (Number(currentIndex) + 1) / maxIndex) * 100 : 100
        },
    },
    methods: {
        updateCurrentIndex() {
            this.$emit('updateCurrentIndex', this.progress.currentIndex);
        }

    }
}

export interface ProgressBarType {
    currentIndex: number;
    minIndex: number;
    maxIndex: number;
}
</script>

<style scoped>
.progress {
    position: relative;
    margin-bottom: 2em;
}

.progress input {
    background-color: transparent;
    position: absolute;
    margin-left: 5px;
    z-index: 5;
    width: 50px;
    border: transparent;
    font-weight: 900;
    font-size: 16px;
}

.progress input:focus,
.progress input:hover {
    color: var(--vue-green);
}

.progress .fill {
    position: absolute;
    left: 0;
    right: 0;
    height: 20px;
    z-index: 1;
    background-color: var(--vue-green-hovered);
}

.progress .background {
    background: repeating-linear-gradient(45deg,
            transparent,
            transparent 6px,
            var(--vue-green-hovered) 6px,
            var(--vue-green-hovered) 12px);
    width: auto;
    height: 20px;
}
</style>
