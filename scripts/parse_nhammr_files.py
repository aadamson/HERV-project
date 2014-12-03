
import os
import fileinput


def get_hits_from_nhammr_file(filename):
    hits = []
    flipped_start_end = 0
    for line in fileinput.input(filename):
        if line.startswith("#"):
            # Comment
            continue
        if "Annotation for each" in line:
            # We've reached the end of the hits, break
            break

        elems = line.split()
        if len(elems) < 5:
            # This isn't a hit line
            continue

        chr = elems[3]
        start = elems[4]
        end = elems[5]

        if "chr" not in chr:
            # This just looks like a hit line but isn't one
            print "ERROR: '%s' doesn't look like a chromosome" % chr
            continue

        start = int(start)
        end = int(end)

        if end < start:
            flipped_start_end += 1
            v = start
            start = end
            end = v

        hits.append([chr, str(start), str(end)])

    print "\t %d hits had weird start-end positions" % flipped_start_end

    return hits




INPUT_DIR = "nhammr-files"
OUTPUT_DIR = "nhammr-bed-files"

files = os.listdir(DIR)
files = filter(lambda x: ".hits" in x, files)

for f in files:
    print "%s..." % f

    filename = os.path.join(INPUT_DIR, f)
    hits = get_hits_from_nhammr_file(filename)
    print "\t\t%d hits" % len(hits)

    # Sort by chromosome
    hits.sort(key=lambda x: x[0])

    # Write these to BED file
    outfilename = os.path.join(OUTPUT_DIR, f.replace(".hits", ".bed"))
    open(outfilename, 'w').write("\n".join(map(lambda x: "\t".join(x), hits)))





