IMAGES = myproject-created-annotated \
	gradle-plugin-overview

SRCIMAGES := $(foreach file, $(IMAGES), $(file).svg)
TRGIMAGES := $(foreach file, $(IMAGES), ../images/$(file).png)

images: $(TRGIMAGES) FORCE

$(TRGIMAGES): ../images/%.png: %.svg
	inkscape --export-png $@ --export-dpi=150 --export-area-drawing $<

FORCE:
