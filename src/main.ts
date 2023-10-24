import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import TheButton from './components/TheButton.vue'

const app = createApp(App)
app.use(router)

app.mount('#app')
app.component('TheButton', TheButton);

