Vue.component("app-maze", {
  template: `
  <div class="col-md-9" @mouseup="clicking = false">
    <div class="row pt-1 m-0">
    <div class="col-md-1 col-xs-6 p-1">
        <strong>Rows</strong>
        <input
          v-model="rows"
          type="number"
          class="form-control"
          placeholder="Rows"
        />
      </div>
      <div class="col-md-1 col-xs-6 p-1">
        <strong>Columns</strong>
        <input
          v-model="columns"
          type="number"
          class="form-control"
          placeholder="Columns"
        />
      </div>
       <div class="col p-1">
        <strong>Draw Maze</strong>
        <div class="btn-group btn-group-toggle btn-block" data-toggle="buttons">
          <label class="btn btn-secondary">
            <input @click="editMode='empty'"  type="radio" name="options" /> Empty
          </label>
          <label class="btn btn-secondary active">
            <input @click="editMode='wall'" type="radio" name="options" checked />
            Wall
          </label>
          <label class="btn btn-secondary">
            <input @click="editMode='start'" type="radio" name="options" /> Start
          </label>
          <label class="btn btn-secondary">
            <input @click="editMode='goal'" type="radio" name="options" /> Goal
          </label>
        </div>
      </div>
       <div class="col p-1">
        <strong>Utilities</strong>
        <div class="btn-group btn-group-toggle btn-block" data-toggle="buttons">
          <label class="col  btn btn-secondary">
            <input @click="generateMaze()"  type="radio" name="options" /> Random Maze
          </label>
          <label class="col btn btn-secondary">
            <input @click="resetMaze()"  type="radio" name="options" /> Reset
          </label>
          <label class="col btn btn-secondary">
            <input @click="cleanMaze()"  type="radio" name="options" /> Clean
          </label>

        </div>
      </div>
    </div>
    <div class="row justify-content-center align-content-center _table-container h-75 mt-2" ref="tc">
        <table :key="updater">
          <tr v-for="row in Number(rows)" :key="row">
            <td
              v-for="col in Number(columns)"
              :key="col"
              :id="'cell-'+row+'-'+col"
              @mousedown="setState(row-1,col-1)"
              @mouseup="stopClicking()"
              @mouseover="hovering(row-1,col-1)"
              class="cell"
              :class="maze[row-1][col-1]"
            ></td>
          </tr>
        </table>
    </div>
   </div>
  </div>

  `,
  props: ["mazeobj"],
  data: () => ({
    MAX_ROWS: 100,
    MAX_COLS: 100,
    columns: 10,
    rows: 10,
    maze: [],
    editMode: "wall", // empty, start, goal
    updater: 0,
    clicking: false,
  }),
  created() {
    this.resetMaze();

    window.addEventListener("mousedown", this.startClicking);
    window.addEventListener("mouseup", this.stopClicking);
    eventBus.$on("find-path-clicked", () => this.findPath());
  },
  mounted() {
    const width = this.$refs.tc.clientWidth;
    const height = this.$refs.tc.clientHeight;
    this.columns = Math.floor(width / 32);
    this.rows = Math.floor(height / 32);
    this.resetMaze();
    this.generateMaze();
  },
  beforeDestroyed() {
    window.removeEventListener("mouseup", this.stopClicking);
    window.removeEventListener("mousedown", this.startClicking);
  },
  methods: {
    stopClicking() {
      this.clicking = false;
    },
    startClicking() {
      this.clicking = true;
    },
    hovering(row, col) {
      if (this.clicking) {
        this.setState(row, col);
      }
    },
    setState(row, col) {
      this.maze[row][col] = this.editMode;
      this.updater++;
    },
    getCellState(row, col) {
      return this.maze[row][col];
    },
    generateCode() {
      let res = [];
      res.push("columns(" + this.columns + ").");
      res.push("rows(" + this.rows + ").");
      let start = "";
      let goals = [];
      let walls = [];
      for (let i = 0; i < this.rows; i++) {
        for (let j = 0; j < this.columns; j++) {
          if (this.maze[i][j] === "start") {
            start = "start(pos(" + (i + 1) + "," + (j + 1) + ")).";
          } else if (this.maze[i][j] === "goal") {
            goals.push("goal(pos(" + (i + 1) + "," + (j + 1) + ")).");
          } else if (this.maze[i][j] === "wall") {
            walls.push("wall(pos(" + (i + 1) + "," + (j + 1) + ")).");
          }
        }
      }
      const bound = `max_bound(${this.rows * this.columns}).`;
      return res
        .concat(bound)
        .concat(start)
        .concat(goals)
        .concat(walls)
        .join("\n");
    },
    findPath() {
      eventBus.$emit("find-path", this.generateCode());
    },
    resetMaze() {
      new Array(this.MAX_ROWS).fill([]).forEach((el, i) => {
        this.maze[i] = new Array(this.MAX_COLS).fill("empty");
      });
      this.updater++;
    },
    cleanMaze() {
      $(".solution").removeClass("solution");
      $(".visited").removeClass("visited");
      $(".current").removeClass("current");
      $(".expanded").removeClass("expanded");
    },
    generateMaze() {
      for (let row = 0; row < this.rows; row++) {
        for (let col = 0; col < this.columns; col++) {
          if (Math.random() < 0.2) {
            this.maze[row][col] = "wall";
          } else {
            this.maze[row][col] = "empty";
          }
        }
      }
      let row = Math.floor(Math.random() * this.rows);
      let col = Math.floor(Math.random() * this.columns);
      this.maze[row][col] = "goal";
      row = Math.floor(Math.random() * this.rows);
      col = Math.floor(Math.random() * this.columns);
      this.maze[row][col] = "start";
      this.updater++;
    },
  },
  computed: {},
});
