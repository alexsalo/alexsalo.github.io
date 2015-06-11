---
layout: post
title: Bellman-Ford Algorithm for Weighted Directed Graph 
---
Bellman-Ford algorithm is easy and sufficiently efficient (~n^3) for finding Shortest Paths (SP). Notably, it finds the shortests paths to __ALL__ the other nodes in the graph.

The idea is simple: for each vertex we mantain the SP (init with inf) and if the precedent vertex + edge weight gives us better sum - then we update current SP value for that vertex.

Caveat: this algorithm fails if graph contains negative cycles since in that case one can obtain arbitrary small (negative) shortest path just by traversing this negative cycle over and over again.  
{% highlight python linenos %}
tart_node):
    N = len(graph)
    sps = dict.fromkeys(graph.keys(), 'inf')
    sps[start_node] = 0
    print sps

    for i in xrange(N):
        # RELAX (for each edge)
        for start in graph.keys():
            adjacent_nodes = graph[start]
            for end in adjacent_nodes.keys():
                if sps[end] > sps[start] + adjacent_nodes[end]:
                    sps[end] = sps[start] + adjacent_nodes[end]
                    print sps

bellman_ford(graph, 'a')
{% endhighlight %}
