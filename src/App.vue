<template>
  <main class="app">
    <div class="container">
      <section class="regex">
        <h4>Expression régulière</h4>
        <div class="input-text">
          <input type="text" id="regex-input" placeholder="Entrez votre expression régulière ..." v-model="regex">
          <pre></pre>
        </div>
      </section>
      <section class="test-string">
        <h4>Chaine de test</h4>
        <div class="input-text">
          <textarea 
            name="test-string" 
            id="test-string" 
            cols="30" 
            rows="10" 
            placeholder="Entrez votre chaine de test ..."
            v-model="testString"></textarea>
          <pre contenteditable="true" @input="update"></pre>
        </div>
      </section>
    </div>
  </main>
</template>

<script lang="ts">
import { defineComponent, ref, watch } from 'vue';

export default defineComponent({
  name: 'App',
  components: {},
  setup() {
    const regex = ref<string>('');
    const testString = ref<string>('');

    watch([regex, testString], () => {
      if(regex.value == "" || testString.value == ""){
        return
      }

      [...testString.value].forEach(c => {
        console.log(c)
      })

    })

    const update = (content: string) => {
      console.log(content)
    }

    const match = (match: boolean) => {
      let testStrinContainer = document.getElementById("test-string");
      if(match){
        testStrinContainer?.classList.contains('match') ? '' : testStrinContainer?.classList.add('match')
      } else {
        testStrinContainer?.classList.contains('match') ? testStrinContainer?.classList.remove('match') : ''
      }
    }

    return { regex, testString, update }
  }
});
</script>

<style>
@import './assets/css/index.css'; 

.container {
  width: 70%;
  margin: 3rem auto;
  background-color: #F3F5F6;
  color: #0B090A;
  padding: 1.5rem;
}

h4 {
  border: 1px solid yellow;
  margin: 0.8rem 0.4rem 0.4rem 0;
}

.test-string {
  margin: 1rem 0 0 0;
}
/* .test-string .input-text{
  position: relative;
}
.test-string #test-string {
  background-color: transparent;
}
.test-string pre {
  position: absolute;
  top: 0;
  left: 0;
  widows: 100%;
  height: 100%;
} */
.match {
  background-color: lightblue;
}
.container section {
  border: 1px solid red;
}

</style>
