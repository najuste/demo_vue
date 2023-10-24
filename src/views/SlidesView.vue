<template>
  <main class="slides">
    <ProgressBar :progress="progressBarProps" @updateCurrentIndex="updateProgressIndex" />

    <template v-if="currentSlideIndex < slides.length">

      <TheSlide :slide="slides[currentSlideIndex]" />
    </template>

    <template v-else>
      <p>Chosen slide is not prepared yet... would you like to watch about Vue instead?</p>
      <iframe width="560" height="315" src="https://www.youtube.com/embed/2EmYw-O-WLI?si=jrVOCYyygfIT8Fml"
        title="YouTube video player" frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
        allowfullscreen></iframe>
    </template>


    <div class="navigation">
      <TheButton @click="currentSlideIndex > 0 && currentSlideIndex--">Prev</TheButton>
      <TheButton @click="currentSlideIndex < slides.length && currentSlideIndex++">Next</TheButton>
    </div>

  </main>
</template>

<script lang="ts">
import { computed, type PropType } from 'vue';
import ProgressBar, { type ProgressBarType } from '@/components/ProgressBar.vue';
import TheSlide, { type SlideType } from '../components/TheSlide.vue'
import TheButton from '../components/TheButton.vue'

export default {
  components: {
    TheSlide,
    ProgressBar,
  },
  props: {
    slides: {
      type: Object as PropType<Array<SlideType>>,
      required: true
    }
  },
  data() {
    return {
      currentSlideIndex: 0,
    }
  },
  provide() {
    return {
      progressBarProps2: this.progressBarProps,
    }
  },
  computed: {
    slidesLength() {
      return this.$props.slides.length;
    },
    progressBarProps(): ProgressBarType {
      return {
        currentIndex: this.currentSlideIndex,
        minIndex: 0,
        maxIndex: this.$props.slides.length
      }
    }
  },
  watcher: {
    currentSlideIndex(newValue: Number | String) {
      if (typeof newValue === 'string') {
        this.currentSlideIndex = 0;
      }
    },
  },
  mounted() {
    window.addEventListener('keydown', this.handleKey);
  },
  beforeDestroy() {
    window.removeEventListener('keydown', this.handleKey);
  },
  methods: {
    updateProgressIndex(updatedIndex: number) {
      this.currentSlideIndex = updatedIndex;
    },
    handleKey(event: KeyboardEvent) {
      if (event.key === "ArrowLeft") {
        this.currentSlideIndex > 0 &&
          this.currentSlideIndex--
      }
      if (event.key === "ArrowRight") {
        this.currentSlideIndex < this.slides.length &&
          this.currentSlideIndex++
      }
    },
  },
};
</script>


<style scoped>
.slides {
  margin-top: 32px;
}

.slide {
  margin-bottom: 32px;
}

.navigation {
  display: flex;
  justify-content: space-between;
}
</style>
