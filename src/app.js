const MAX_RESOLUTION_STEPS = 10000;
const MODULES = ":- use_module(library(lists)).";
const session = pl.create(MAX_RESOLUTION_STEPS);
session.consult(MODULES);

function query(query) {
  session.query(query);
  let answers_list = [];
  let current_answer = true;
  while (current_answer) {
    session.answer((ans) => {
      current_answer = ans;
      // console.log(ans, pl.format_answer(ans));
      answers_list.push(pl.format_answer(ans));
    });
  }
  return answers_list;
}

var app = new Vue({
  el: "#app",
  data: () => ({
    knowledgeBase: [],
    session,
    pl,
  }),
  watch: {},
  beforeCreate() {
    fetch("src/prolog-scripts/antenati.pl")
      .then((res) => res.text())
      .then((res) => {
        this.knowledgeBase.push(res);
        session.consult(res);
      });
    fetch("src/prolog-scripts/labirinto.pl")
      .then((res) => res.text())
      .then((res) => {
        this.knowledgeBase.push(res);
        session.consult(res);
      });
  },
  created() {},
  methods: {},
  computed: {
    // a computed getter
    program: function () {
      return this.knowledgeBase.join("\n");
    },
  },
});
