Vue.component("pms-toolbar", {
    template: `
        <div class="navbar navbar-light navbar-expand-lg">
            <a class="navbar-brand" href="#" >{{title}} </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
         <div class="collapse navbar-collapse" id="navbarNav">
            <div class="navbar-nav row">
                <div class="col-md-6">
                    <div class="btn-group btn-group-toggle btn-block" data-toggle="buttons">
                      <label class="btn btn-outline-primary">
                        <input @click="setStrategy('dfs')"  type="radio" name="options" /> DFS
                      </label>
                      <label class="btn bbtn-outline-primary active">
                        <input @click="setStrategy('bfs')" type="radio" name="options" checked /> BFS
                      </label>
                      <label class="btn btn-outline-primary">
                        <input @click="setStrategy('iddfs')" type="radio" name="options" /> IDDFS
                      </label>
                      <label class="btn btn-outline-primary">
                        <input  @click="setStrategy('idastar')" type="radio" name="options" /> IDA*
                      </label>
                      <label class="btn btn-outline-primary">
                        <input  @click="setStrategy('astar')" type="radio" name="options" /> A*
                      </label>
                    </div>
                  </div>
                <div class="col-md-2">
                    <button class="btn btn-primary btn-block" @click="findPath()">Find Path</button>
                </div>
                </div>
            </div>
        </div>`,
    props: ["title"],
});
