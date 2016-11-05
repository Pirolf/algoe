const white = 0;
const grey = 1;
const black = 2;

function dfs(graph, vertices) {
  const verticesInfo = vertices.map(v => ({color: white}));

  let time = {v: 0};
  vertices.forEach(v => {
    if (verticesInfo[v].color === white) dfsVisit(graph, verticesInfo, v, time);
  });
}

function dfsVisit(graph, verticesInfo, v, time) {
  verticesInfo[v].color = grey;
  time.v ++;
  verticesInfo[v].discover = time.v;
  console.log('discovered ', v, ' at ', time.v);

  graph[v].forEach(c => {
    if (verticesInfo[c].color === white) {
      dfsVisit(graph, verticesInfo, c, time);
    }
  });

  verticesInfo[v].color = black;
  time.v ++;
  verticesInfo[v].finish = time.v;
  console.log('finished ', v, ' at ', time.v);
}

const vertices = [0, 1, 2, 3, 4, 5];
const graph = [
  [1, 2],
  [3],
  [1, 3],
  [],
  [5],
  [4]
];
dfs(graph, vertices);

module.exports = dfs;
