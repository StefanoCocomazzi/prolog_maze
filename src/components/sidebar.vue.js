Vue.component("pms-toolbar", {
  template: `
<div class="navbar navbar-expand-lg navbar-light col-lg-3 border-right border-secondary">
   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
     <span class="navbar-toggler-icon"></span>
   </button>
  <div class="collapse navbar-collapse row min-vh-100 align-content-start" id="navbarSupportedContent">
    <div class="col-12 mt-1 mb-1">
      <h5>Solving Strategy</h5>
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
    <div class="col-12 mt-1 mb-1">
      <h5>Heuristic</h5>
      <div class="btn-group btn-group-toggle btn-block" data-toggle="buttons">
        <label class="col btn btn-outline-primary active">
          <input
            @click="setStrategy('dfs')"
            type="radio"
            name="options"
            checked
          />
          Manhattan Distance
        </label>
        <label class="col btn btn-outline-primary">
          <input @click="setStrategy('bfs')" type="radio" name="options" /> Euclidean Distance
        </label>

      </div>
    </div>
    <div class="col-12 mt-1 mb-1">
        <h5>Travel Speed</h5>
        <div class="input-group">
            <input @change="setTravelSpeed"
              v-model="speed"
              type="number"
              class="form-control"
              placeholder="Travel Speed"
            />
            <div class="input-group-append">
                <span class="input-group-text">ms</span>
            </div>
        </div>
    </div>
    <div class="col-12 mt-1 mb-1">
      <button class="btn btn-success btn-block" @click="findPath()">
        Find Path
      </button>
      <button class="btn btn-primary btn-block" @click="findPath()">
        Retrace Solution
      </button>
    </div>
  </div>
</div>

  `,
  data() {
    return {
      speed: 100,
    };
  },
  methods: {
    setStrategy(strategy) {
      eventBus.$emit("set-strategy", strategy);
    },
    findPath() {
      eventBus.$emit("find-path-clicked");
    },
    setTravelSpeed() {
      eventBus.$emit("set-travel-speed", this.speed);
    },
  },
});
