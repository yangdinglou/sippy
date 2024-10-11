% Nodes
node(aa).
node(bb).
node(cc).
node(dd).

% Left children
left(aa, bb).
left(bb, null).
left(cc, dd).
left(dd, null).

% Right children
right(aa, cc).
right(bb, null).
right(cc, null).
right(dd, null).


entrypoint(aa).