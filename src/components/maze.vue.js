Vue.component("app-maze", {
    template: `
  <div class="container" @mouseup="clicking = false">
    <div class="row pt-3 justify-content-center">
    <div class="col-md-3 col-xs-6 pb-2">
        <input
          v-model="rows"
          type="number"
          class="form-control"
          placeholder="Rows"
        />
      </div>
      <div class="col-md-3 col-xs-6 pb-2">
        <input
          v-model="columns"
          type="number"
          class="form-control"
          placeholder="Columns"
        />
      </div>
    </div>  
    <div class="row justify-content-center">
       <div class="col-md-6 pb-1">
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
    </div>
    <div class="row justify-content-center _table-container" >
        <table :key="updater">
          <tr v-for="row in Number(rows)" :key="row">
            <td
              v-for="col in Number(columns)"
              :key="col"
              :id="'cell'+row+''+col"
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
        MAX_ROWS: 25,
        MAX_COLS: 25,
        columns: 10,
        rows: 10,
        maze: [],
        editMode: "wall", // empty, start, goal
        updater: 0,
        clicking: false
    }),
    created() {
        new Array(this.MAX_ROWS).fill([]).forEach((el, i) => {
            this.maze[i] = new Array(this.MAX_COLS).fill("empty");
        });
        window.addEventListener('mousedown', this.startClicking);
        window.addEventListener('mouseup', this.stopClicking);
    },
    beforeDestroyed() {
        window.removeEventListener('mouseup', this.stopClicking);
        window.removeEventListener('mousedown', this.startClicking);
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
                        start = "start(pos(" + (i + 1) + "," + (j + 1) + "))."
                    } else if (this.maze[i][j] === "goal") {
                        goals.push("goal(pos(" + (i + 1) + "," + (j + 1) + ")).");
                    } else if (this.maze[i][j] === "wall") {
                        walls.push("wall(pos(" + (i + 1) + "," + (j + 1) + ")).");
                    }
                }
            }
            return res.concat(start).concat(goals).concat(walls).join("\n");
        },
        findPath() {
            eventBus.$emit("find-path", this.generateCode());
        },
    },
    computed: {},
});
