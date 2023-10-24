# Vue released in 2014

- Evan You, ex-Googler (Angular, Meteor) - a single creator
- a view layer only

```vue
<div id="app">
  <h1>{{ message }}</h1>
  <ul>
    <li v-repeat="item: items">{{ item }}</li>
  </ul>
  <button v-on="click: addItem">Add Item</button>
</div>
<script src="vue.js"></script>
<script>
var app = new Vue({
	el: "#app",
	data: {
		message: "Hello Vue!",
		items: ["apple", "banana", "orange"],
	},
	methods: {
		addItem: function () {
			this.items.push("pear");
		},
	},
});
</script>
```

# Vue2.0 released in 2016 Sept

- 11 active maintainers
- 25.857 Github starts
- Major rewrite with improvements: vDOM implementation, flexible components, Vuex, Vue Router, SSR solution, Typescript support

```vue
<div id="app">
  <h1>{{ message }}</h1>
  <ul>
    <li v-for="item in items" :key="item">{{ item }}</li>
  </ul>
  <button @click="addItem">Add Item</button>
</div>

<script src="vue.js"></script>
<script>
var app = new Vue({
	el: "#app",
	data: function () {
		return {
			message: "Hello Vue!",
			items: ["apple", "banana", "orange"],
		};
	},
	methods: {
		addItem: function () {
			this.items.push("pear");
		},
	},
});
</script>
```

# Vue2.7 released in 2022 July

- 192.882 Github stars
- the final minor release

# Vue3.0 released in 2020 Sept 18.

- 30 active maintainers
- 167.787 Github stars
- composition API for flexible component logic
- re-written reactivity system for better performance and compatibility
- has a compiler that supports multiple build targets: web, native, ...
- smaller bundle: smaller core size and better tree-shaking support
- kind of TS native with official typings for the core library and ecosystem tools
- enhanced support for custom elements and web components

```vue
<div id="app">
  <h1>{{ message }}</h1>
  <ul>
    <li v-for="item in items" :key="item">{{ item }}</li>
  </ul>
  <button @click="addItem">Add Item</button>
</div>

<script src="vue.global.js"></script>
<script>
const app = Vue.createApp({
	data() {
		return {
			message: "Hello Vue!",
			items: ["apple", "banana", "orange"],
		};
	},
	methods: {
		addItem() {
			this.items.push("pear");
		},
	},
});
app.mount("#app");
</script>
```

# How to start with Vue.js: scafolling

- From Node
  `npm create vue@latest && cd my-project && npm install && npm run dev`
- Vue CLI
  `npm install -g @vue/cli && vue create my-project && cd my-project && npm run serve`
- Vite
  `npm install -g create-vite && create-vite my-project --template vue && cd my-project && npm run dev`
- other tool are less known
- no need to scafold: import Vue as script directly from `<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>`
  And write your vue code

# Vue.js main feature: HTML templates within component

- primarly HTML templates and not JSX (though available). Better human readability and faster learning curve
- components contain html (\<template>), \<script> and \<style>
- vue template separate from script

```vue
<template>
	<div>
		<h1 v-if="isUserLoggedIn">Welcome, User!</h1>
		<h1 v-else>Welcome, Guest!</h1>
	</div>
</template>
```

- react is script only: jsx extension to bind all in one file

```jsx
function Smth() {
	return (
		<div>
			{isUserLoggedIn ? <h1>Welcome, User!</h1> : <h1>Welcome, Guest!</h1>}
		</div>
	);
}
```

# Vue.js syntax: component anatomy

- spliting UI
- stored in .vue files that can contain template, script and style

<img src="https://i.imgur.com/tE8XNbq.png">

# Vue.js syntax: HTML bindings, directives, events - simple html rendering

- v-if, v-else; load and hide v-show;
- render as html: v-html;
- lists: v-for="(value, name, index) in object"
- value binding ':', accesing also native html attributes; modifier '.attr' to bind to attributes(!)
- 2way value binding v-model on \<input />

<img src="https://i.imgur.com/Mi9qblk.png">

# Vue Router basic setup

- router exposes all the routes with components to render
- using in html with router-link or also accessing $router and $route globals
  <img src="/src/assets/img/Vue-Router-Cheat-Sheet1.jpg">

# Vue Router: guards

- global navigation guards as router.beforeEach check if authenticated, can access, or afterEach for sending analytics
- per-route guards beforeEnder to fetch data or remove query params
- routes can have meta fields for example flag if auth is required or pass some props
- routes can be lazy loaded
