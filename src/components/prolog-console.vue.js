Vue.component("prolog-console", {
    template: `<div>
  <div class="accordion" id="accordionInterprete">
    <div class="card">
      <div class="card-header" id="headingOne">
        <h2 class="mb-0">
          <button
            class="btn btn-link btn-block text-left"
            type="button"
            data-toggle="collapse"
            data-target="#collapseOne"
            aria-expanded="false"
            aria-controls="collapseOne"
          >
            Prolog Console
          </button>
        </h2>
      </div>

      <div
        id="collapseOne"
        class="collapse"
        aria-labelledby="headingOne"
        data-parent="#accordionInterprete"
      >
        <div class="card-body">
          <div id="prolog-console-app" @keydown.ctrl.enter="runProlog()">
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

            <button type="button" class="btn btn-dark" @click="runProlog()" v-on:keypress.ctrl.enter="runProlog()">
              run
            </button>

            <pre style="margin: 1em;">{{answers}}</pre>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
`,
    props: ["program", "session", "pl"],

    data: () => ({
        query: "",
        answers: "",
        libs: ":- use_module(library(lists))",
    }),
    created() {
    },
    methods: {
        runProlog() {
            this.answers = "";
            this.query = this.query.trim();
            if (this.query.substr(-1) !== ".") {
                this.query += ".";
            }
            // const session = pl.create(1000);
            // session.consult(this.libs + " " + this.program);
            this.session.query(this.query);
            session.answers((x) => {
                this.answers = this.answers.concat(this.pl.format_answer(x), "\n");
            });
        },
    },
});
