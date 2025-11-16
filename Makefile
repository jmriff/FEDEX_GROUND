execute :
	./run.sh

shared :
	./run.sh
	rm -f ~/shared/*
	cp label* ~/shared/


clean:
	rm -f response.json *gif *pdf *jpg *zpl *png
	echo "Spick and Span!"
