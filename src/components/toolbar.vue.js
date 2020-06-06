Vue.component("pms-toolbar", {
  template: `
<div class="container-fluid pt-3">
  <div class="row  justify-content-between">
    <div class="col-md-6 mt-1">
      <div class="btn-group btn-group-toggle btn-block" data-toggle="buttons">
        <label class="col btn btn-outline-primary active">
          <input
            @click="setStrategy('dfs')"
            type="radio"
            name="options"
            checked
          />
          DFS
        </label>
        <label class="col btn btn-outline-primary">
          <input @click="setStrategy('bfs')" type="radio" name="options" /> BFS
        </label>
        <label class="col btn btn-outline-primary">
          <input @click="setStrategy('iddfs')" type="radio" name="options" />
          IDDFS
        </label>
        <label class="col btn btn-outline-primary">
          <input @click="setStrategy('idastar')" type="radio" name="options" />
          IDA*
        </label>
        <label class="col btn btn-outline-primary">
          <input @click="setStrategy('astar')" type="radio" name="options" /> A*
        </label>
      </div>
    </div>
    <div class="col-md-3 mt-1">
      <button class="btn btn-success btn-block" @click="findPath()">
        Find Path
      </button>
    </div>
  </div>
</div>

  `,
  methods: {
    setStrategy(strategy) {
      eventBus.$emit("set-strategy", strategy);
    },
    findPath() {
      eventBus.$emit("find-path-clicked");
    },
  },
});
