<template>
  <main class="app">
    <div class="container">
      <section class="regex">
        <h4>Expression régulière</h4>
        <div class="input-text">
          <textarea id="regex-input" placeholder="Entrez votre expression régulière ..." v-model="regex" style="display: none"></textarea>
          <!-- <input type="text" id="regex-input" placeholder="Entrez votre expression régulière ..." v-model="regex"> -->
        </div>
      </section>
      <section class="test-string">
        <h4>Chaine de test</h4>
        <!-- <div class="input-text"> -->
        <div>
          <textarea id="test-string" placeholder="Entrez votre chaîne de test ..." v-model="testString" style="display: none"></textarea>
        </div>
      </section>
    </div>
  </main>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref, watch } from 'vue';
import * as CodeMirror from 'codemirror';
import 'codemirror/lib/codemirror.css';
import 'codemirror/theme/dracula.css';

import 'codemirror/addon/display/placeholder';

export default defineComponent({
  name: 'App',
  components: {},
  setup() {
    const regex = ref<string>('');
    const testString = ref<string>('');


    onMounted(() => {
      const regexEditor = CodeMirror.fromTextArea(document.getElementById('regex-input') as HTMLTextAreaElement, {
        lineNumbers: true,
        theme: 'dracula',
        mode: "none"
      })

      const testStringEditor = CodeMirror.fromTextArea(document.getElementById('test-string') as HTMLTextAreaElement, {
        lineNumbers: true,
        theme: 'dracula',
        mode: 'regex'
      })
      
      regexEditor.on("change", (element) => {
        regex.value = element.getValue();
        setTimeout(() => {
          testStringEditor.setValue(testStringEditor.getValue());
        },10)
        
      })
    })
    
    CodeMirror.defineMode("regex",function() {
      return {
        token: function(stream, state) {
          try {
              var regexExp = new RegExp(regex.value, 'g')
              if(stream.match(regexExp)) {
                stream.eat(regexExp)
                return "regex";
              } else {
                stream.next();
                return null;
              }
          } catch (error) {
            stream.next();
            return null;
          }
        } 
      } 
    })

    const match = (match: boolean) => {
      let testStrinContainer = document.getElementById("test-string");
      if(match){
        testStrinContainer?.classList.contains('match') ? '' : testStrinContainer?.classList.add('match')
      } else {
        testStrinContainer?.classList.contains('match') ? testStrinContainer?.classList.remove('match') : ''
      }
    }

    return { regex, testString }
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

.container section {
  border: 1px solid red;
}

</style>
