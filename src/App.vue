<template>
    <div id="app" @keydown.ctrl.enter="runProlog()">
        <section>
            <div>
                <h2>Knowledge Base</h2>
                <textarea
                        name="input-7-1"
                        v-model="program"
                        placeholder="Write Program"
                ></textarea>
            </div>
            <div>
                <h2>Query</h2>
                <textarea
                        name="input-7-1"
                        v-model="query"
                        placeholder="Query the KB. [ctrl + enter] to execute"
                ></textarea>
            </div>
        </section>

        <button @click="runProlog()" v-on:keypress.ctrl.enter="runProlog()">run</button>

        <pre>{{answers}}</pre>
        <!--        <HelloWorld msg="Welcome to Your Vue.js App"/>-->

    </div>
</template>

<script>
    // import HelloWorld from './components/Main.vue'
    const pl = require("@dipta004/tau-prolog-mod-react");
    require("@dipta004/tau-prolog-mod-react/modules/lists")(pl);
    export default {
        name: 'App',
        data: () => ({
            libs: ":- use_module(library(lists)). ",
            program: '',
            query: '',
            answers: '',
        }),
        components: {
            // HelloWorld
        },
        created() {
            this.program =
                "fruit(apple). \nfruit(pear). \nfruit(banana). \n" +
                "fruits_in(Xs, X) :-\n\t member(X, Xs),\n\t fruit(X).";
        },
        methods: {
            runProlog() {
                this.answers = '';
                this.query = this.query.trim()
                if (this.query.substr(-1) !== '.') {
                    this.query += '.'
                }
                const session = pl.create(1000);
                session.consult(this.libs + ' ' + this.program);
                session.query(this.query);
                session.answers(x => {
                    this.answers = this.answers.concat(pl.format_answer(x), '\n')
                });
            }
        }
    }
</script>

<style>
    #app {
        font-family: Avenir, Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-align: center;
        color: #2c3e50;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    section {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        gap: 1em;
    }

    textarea {
        width: 36vw;
        height: 36vh;
    }

    pre {
        width: 36vw;
        height: 28vh;
        font-family: monospace;
        text-align: left;
        background: #2c3e50;
        color: aliceblue;
        font-size: large;
    }

    button {
        margin-top: 1em;
        width: 8vw;
    }
</style>
