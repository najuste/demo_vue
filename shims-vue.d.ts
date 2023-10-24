declare module '*.vue' {
    import { ComponentOptions } from 'vue';
    const component: ComponentOptions;
    export default component;
  }

// also npm install vue @types/vue --save-dev
// also in tsconfig.json under compilerOptions asllow synthetic Imports