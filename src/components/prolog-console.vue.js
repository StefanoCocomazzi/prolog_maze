const MAX_RESOLUTION_STEPS = 100000;
const MODULES = ":- use_module(library(lists)).";
const session = pl.create(MAX_RESOLUTION_STEPS);
session.consult(MODULES);

Vue.component("prolog-console", {
  template: `<div>
  <div class="accordion fixed-bottom" id="accordionInterprete">
    <div class="card">
      <div class="card-header" id="headingOne">
        <h2 class="mb-0">
          <button
            class="btn btn-link btn-block text-left mt-0"
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
        <div class="card-body" :key="updater">
          <div id="prolog-console-app" @keydown.ctrl.enter="runProlog()">
            <section class="row">
              <div class="col">
                <h2>Knowledge Base</h2>
                <textarea
                  name="input-7-1"
                  v-model="knowledgeBase.program"
                  placeholder="Write Program"
                ></textarea>
              </div>
              <div class="col">
                <h2>Query</h2>
                <textarea
                  name="input-7-1"
                  v-model="query"
                  placeholder="Query the KB. [ctrl + enter] to execute"
                ></textarea>
              </div>
              <div class="col">
               <button type="button" class="btn btn-outline-success btn-block" @click="runProlog()" v-on:keypress.ctrl.enter="runProlog()">Run</button>
               <div class="answer">{{answers}}</div>
              </div>
            </section>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
`,
  props: ["mazeobj"],

  data: () => ({
    query: "",
    answers: "",
    libs: ":- use_module(library(lists))",
    knowledgeBase: { program: "" },
    updater: 0,
    currentAlgorithm: "dfs",
  }),
  beforeCreate() {},
  created() {
    this.knowledgeBase["travel-speed"] = `travel_speed(100).`;
    this.loadFiles([
      "actions",
      "dom-actions",
      "dfs",
      "bfs",
      "astar",
      "idastar",
    ]);
    eventBus.$on("find-path", (maze) => this.computePath(maze));
    eventBus.$on(
      "set-strategy",
      (strategy) => (this.currentAlgorithm = strategy)
    );
    eventBus.$on("set-travel-speed", (spd) => {
      this.knowledgeBase["travel-speed"] = `travel_speed(${spd}).`;
      console.log(this.knowledgeBase["travel-speed"]);
    });
  },

  methods: {
    computePath(maze) {
      $(".solution").removeClass("solution");
      $(".visited").removeClass("visited");
      $(".current").removeClass("current");
      $(".expanded").removeClass("expanded");
      this.knowledgeBase.program = maze + this.KB();
      session.consult(this.knowledgeBase.program);
      console.log(this.knowledgeBase.program);

      session.query(`${this.currentAlgorithm}(Solution).`);
      console.log(`${this.currentAlgorithm}(Solution).`);

      session.answer((ans) => this.handleSolution(ans));
    },
    runProlog() {
      session.consult(this.knowledgeBase.program);
      this.answers = "";
      this.query = this.query.trim();
      if (this.query.substr(-1) !== ".") {
        this.query += ".";
      }
      this.answers = this.getAnswerlist(this.query).join("\n");
    },

    getAnswerlist(query) {
      // const session = pl.create();
      session.consult(this.knowledgeBase.program);
      session.query(query);
      let answers_list = [];
      let current_answer = true;
      while (current_answer) {
        session.answer((ans) => {
          current_answer = ans;
          answers_list.push(pl.format_answer(ans));
        });
      }
      return answers_list;
    },

    KB() {
      return (
        "\n" +
        this.knowledgeBase["travel-speed"] +
        "\n" +
        this.knowledgeBase["actions"] +
        "\n" +
        this.knowledgeBase["dom-actions"] +
        "\n" +
        this.knowledgeBase[this.currentAlgorithm]
      );
    },
    handleSolution(ans) {
      console.log(pl.format_answer(ans));
      this.answers = pl.format_answer(ans);
      const path = pl.format_answer(ans).split("=")[1].split(";")[0];
      session.query(`visualizeSolution(${path}).`);
      console.log(`visualizeSolution(${path}).`);

      session.answer((ans) => console.log("XXX", ans));
    },
    loadFiles(arr) {
      arr.forEach((fileName) => {
        fetch(`src/prolog-scripts/${fileName}.pl`)
          .then((res) => res.text())
          .then((res) => {
            this.knowledgeBase[fileName] = res;
          });
      });
    },
  },
  computed: {},
});
