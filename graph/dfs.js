var white = 0;
var grey = 1;
var black = 2;

function dfs(graph, vertices) {
  var verticesInfo = vertices.map(function(v) {
    return {color: white};
  });

  var time = {v: 0};
  vertices.forEach(function(v) {
    if (verticesInfo[v].color === white) dfsVisit(graph, verticesInfo, v, time);
  });
}

function dfsVisit(graph, verticesInfo, v, time) {
  verticesInfo[v].color = grey;
  time.v ++;
  verticesInfo[v].discover = time.v;
  console.log('discovered ', v, ' at ', time.v);

  graph[v].forEach(function(c) {
    if (verticesInfo[c].color === white) {
      newTime = dfsVisit(graph, verticesInfo, c, time);
    }
  });

  verticesInfo[v].color = black;
  time.v ++;
  verticesInfo[v].finish = time.v;
  console.log('finished ', v, ' at ', time.v);
}

var vertices = [0, 1, 2, 3, 4, 5];
var graph = [
  [1, 2],
  [3],
  [1, 3],
  [],
  [5],
  [4]
];
dfs(graph, vertices);
