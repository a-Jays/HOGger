# HOGger
A poor-man's implementation of HOG descriptor, in Octave.

Execute computeHOGs.m as a script in the source folder.
This is the folder that contains two folders, one having negative and one having positive class images. Change the folder (and file) path names accordingly.

Takes ~125ms to compute HOG of a `128x64` patch. Runs using `nproc-1` workers (one core is left free for listening to music meanwhile..!). Requires the parallel toolbox from Octave-Forge.

Creates two cell arrays, `NonPersonHOG` and `PersonHOG`, with each cell element as the the HOG of one image. This can be given to `cell2mat()` and transposed to get the familiar feature matrix.

TODO:

-- Add option to automatically extract HOGs from as many patches as possible from an image of size larger than `128x64`. Requires expansion/concatenation of cells. Tricky, but not undoable (by using a loop..)

-- Add PCA/LDA to reduce dimensionality of this thing.

-- Add learning.
