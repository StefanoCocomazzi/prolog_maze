Vue.component("app-maze", {
  template: `
  <div class="container">
    <div class="form-row">
      <div class="col-2">
        <input
          v-model="rows"
          type="number"
          class="form-control"
          placeholder="Rows"
        />
      </div>
      <div class="col-2">
        <input
          v-model="columns"
          type="number"
          class="form-control"
          placeholder="Columns"
        />
      </div>
      <div class="col">
        <div class="btn-group btn-group-toggle btn-block" data-toggle="buttons">
          <label class="btn btn-secondary active">
            <input @click="editMode='wall'" type="radio" name="options" checked />
            Wall
          </label>
          <label class="btn btn-secondary">
            <input @click="editMode='empty'" type="radio" name="options" /> Empty
          </label>
          <label class="btn btn-secondary">
            <input @click="editMode='start'" type="radio" name="options" /> Start
          </label>
          <label class="btn btn-secondary">
            <input @click="editMode='goal'" type="radio" name="options" /> Goal
          </label>
        </div>
      </div>
      <div class="col-2">
        <button class="btn btn-primary btn-block" @click="findPath()">Find Path</button>
      </div>
    </div>
    <div class="row pt-5 justify-content-center flex-grow-1">
      <div class="col">
        <table :key="updater">
          <tr v-for="row in Number(rows)" :key="row">
            <td
              v-for="col in Number(columns)"
              :key="col"
              :id="row*col"
              @click="setState(row-1,col-1)"
              class="cell"
              :class="maze[row-1][col-1]"
            ></td>
          </tr>
        </table>
      </div>
      <div class="col-4">
        <pre>{{generateCode()}}</pre>
      </div>
    </div>
   </div>
  </div>

  `,
  props: ["mazeobj"],
  data: () => ({
    MAX_ROWS: 25,
    MAX_COLS: 25,
    columns: 10,
    rows: 10,
    maze: [],
    editMode: "wall", // empty, start, goal
    updater: 0,
  }),
  created() {
    new Array(this.MAX_ROWS).fill([]).forEach((el, i) => {
      this.maze[i] = new Array(this.MAX_COLS).fill("empty");
    });
  },
  methods: {
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
      for (let i = 0; i < this.rows; i++) {
        for (let j = 0; j < this.columns; j++) {
          if (this.maze[i][j] !== "empty") {
            res.push(
              this.maze[i][j] + "(pos(" + (i + 1) + "," + (j + 1) + "))."
            );
          }
        }
      }

      this.mazeobj.string = res.join("\n");
      return res;
    },
    findPath() {
      eventBus.$emit("find-path");
    },
  },
  computed: {},
});
