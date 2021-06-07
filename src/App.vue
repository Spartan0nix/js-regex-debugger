<template>
  <main class="app">
    <div class="container">
      <section class="regex">
        <h4>Expression régulière</h4>
        <div class="regex-input">
          <pre>
            <span>&ZeroWidthSpace;</span>
          </pre>
        </div>
      </section>
      <section class="test-string">
        <h4>Chaine de test</h4>
        <div class="test-string-input">
          <pre>
            <span>&ZeroWidthSpace;</span>
          </pre>
        </div>
      </section>
    </div>
  </main>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'App',
  components: {}
});
</script>

<style>
#app {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
.app {}

.container {
  width: 70%;
  margin: 3rem auto;
  background-color: #F3F5F6;
  color: #0B090A;
  padding: 1.5rem;
}
.container section {
  border: 1px solid red;
}

.test-string {
  margin: 1rem 0 0 0;
}

h4 {
  border: 1px solid yellow;
  margin: 0.2rem 0 0.2rem 0;
}
</style>
