Vue.component("app-maze", {
  template: `
  <div class="container-fluid">
  <p>{{rows}} x {{columns}}</p>
  <div class="form-row">
    <div class="col">
      <input
        v-model="rows"
        type="number"
        class="form-control"
        placeholder="Rows"
      />
    </div>
    <div class="col">
      <input
        v-model="columns"
        type="number"
        class="form-control"
        placeholder="Columns"
      />
    </div>
    <div class="col">
      <button class="btn btn-block btn-primary">Genera Griglia</button>
    </div>
  </div>
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
  <div class="row">
    <div class="col d-flex align-items-center justify-content-center">
      <table :key="updater">
        <tr v-for="row in Number(rows)" :key="row">
          <td
            v-for="col in Number(columns)"
            :key="col"
            @click="setState(row-1,col-1)"
            class="cell"
            :class="maze[row-1][col-1]"
          ></td>
        </tr>
      </table>
    </div>
  </div>
</div>

  `,
  props: [],
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
  },
  computed: {},
});
