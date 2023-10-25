import './assets/main.css'
import 'highlight.js/styles/stackoverflow-light.css'
import hljs from 'highlight.js/lib/core';
import javascript from 'highlight.js/lib/languages/javascript';
import typescript from 'highlight.js/lib/languages/typescript';
import hljsVuePlugin from "@highlightjs/vue-plugin";

hljs.registerLanguage('javascript', javascript);
hljs.registerLanguage('typescript', typescript);

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import TheButton from './components/TheButton.vue'

const app = createApp(App)
app.use(router)
app.use(hljsVuePlugin)

// global components to use
app.component('TheButton', TheButton);

app.mount('#app')



