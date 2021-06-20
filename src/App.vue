<template>
  <main>
    <h2>Tester vos expressions régulières</h2>
    <div class="container">
      <section class="regex">
        <label for="regex-input"><h3>Expression régulière</h3></label>
        <div class="input-text">
          <textarea id="regex-input" placeholder="Entrez votre expression régulière ..." v-model="regex" style="display: none"></textarea>
        </div>
      </section>
      <section class="test-string">
        <label for="test-string"><h3>Chaine de test</h3></label>
        <div class="input-text">
          <textarea id="test-string" placeholder="Entrez votre chaîne de test ..." v-model="testString" style="display: none"></textarea>
        </div>
      </section>
    </div>
  </main>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref} from 'vue';
import * as CodeMirror from 'codemirror';
import 'codemirror/lib/codemirror.css';
import 'codemirror/theme/dracula.css';
import 'codemirror/theme/nord.css'

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
        mode: "none",
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
          if(regex.value){
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
          } else {
            stream.next();
            return null;
          }
        } 
      } 
    })

    return { regex, testString }
  }
});
</script>

<style>
@import './assets/css/index.css'; 

h2 {
  text-align: center;
  padding: 2rem;
}

.container {
  width: 70%;
  margin: 0 auto;
  background-color: var(--secondary);
  color: var(--font);
  padding: 1.5rem;
}

.container section {
  border-top: 2px solid var(--red);
}

h3 {
  margin: 0.8rem 0.4rem 0.4rem 0;
  font-size: 24px;
}

.regex .input-text {
  height: 3rem;
}

.test-string {
  margin: 1rem 0 0 0;
}

@media screen and (max-width: 600px) {
  .container {
    margin: 0;
    width: auto;
  }
}
</style>
