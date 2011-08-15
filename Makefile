.PHONY: proceedings organization papers toc

all: proceedings

organization:
	publisher/build_template.py cover_material/organization.tex.tmpl scipy_proc.json > output/organization.tex
	(cd output && pdflatex organization.tex)

papers:
	# Build all papers
	./make_all.sh
	# Count page nrs and build toc
	./publisher/build_index.py
	# Build again with new page numbers
	./make_all.sh


toc: papers 
	publisher/build_template.py cover_material/toc.tex.tmpl output/toc.json > output/toc.tex
	publisher/build_template.py cover_material/toc.html.tmpl output/toc.json > output/toc.html
	(cd output && pdflatex toc.tex)

proceedings: toc organization
	publisher/concat_proceedings_pdf.sh
