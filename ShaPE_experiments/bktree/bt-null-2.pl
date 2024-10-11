% Nodes
node(a).
node(b).
node(c).
node(d).
node(e).
node(f).
node(g).
node(h).
node(i).
node(j).
node(k).

% Left children
left(a, b).
left(b, c).
left(c, d).
left(d, null).
left(e, null).
left(f, g).
left(g, null).
left(h, null).
left(i, j).
left(j, null).
left(k, null).

% Right children
right(a, i).
right(b, f).
right(c, e).
right(d, null).
right(e, null).
right(f, h).
right(g, null).
right(h, null).
right(i, k).
right(j, null).
right(k, null).

% back pointers
back(a, null).
back(b, a).
back(c, b).
back(d, c).
back(e, c).
back(f, b).
back(g, f).
back(h, f). 
back(i, a).
back(j, i).
back(k, i).


entrypoint(a).