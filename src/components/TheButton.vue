<template>
  <button :class="['button', size]">
    <i v-if="icon" :class="['icon', icon]"></i>
    <slot></slot>
  </button>
</template>
<script lang="ts">
import { defineComponent } from 'vue';
import { type PropType } from 'vue';

enum ButtonSize {
  S = 'small',
  M = 'normal',
  L = 'large',
}

/** 
 * Global component that gets imported into App.
 * defineComponent  is a type helper for defining a Vue component with type inference.
 * */
export default defineComponent({
  name: 'TheButton',
  props: {
    icon: String,
    size: {
      type: String,
      default: ButtonSize.M,
      validator: (value: string) => {
        return Object.values(ButtonSize).includes(value as ButtonSize);
      },
    },
  },
});
</script>


<style>
.button {
  border: none;
  border-radius: 0.5em;
  background-color: var(--vue-green);
  color: rgb(245, 251, 251);
  padding: 1em;
  min-width: 100px;
  font-weight: 600;
}

.button:hover {
  cursor: pointer;
  filter: brightness(0.8);
}

.button.large {
  font-size: 1.2em;
  font-weight: 500;
}

.button.small {
  padding: 0.5em 1em;
  font-size: 1em;
}
</style>

  