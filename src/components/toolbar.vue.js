Vue.component("pms-toolbar", {
    template: `<div class="navbar navbar-light">
    <a class="navbar-brand" href="#" >{{title}} </a>
  </div>`,
    props: ["title"],
});
