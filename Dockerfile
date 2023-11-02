FROM alpine:latest

RUN apk add --update --no-cache --virtual .build-deps  \
    git

RUN apk add --update --no-cache \
    fontconfig \
    py3-pillow \
    py3-future \
    py3-jinja2 \
    py3-bottle \
    python3 \
    ttf-dejavu

RUN git clone --depth=1 https://github.com/FriedrichFroebel/brother_ql_web.git && \
    rm -r brother_ql_web/.git
WORKDIR ./brother_ql_web
RUN pip install --no-cache-dir .

RUN apk del .build-deps

EXPOSE 8013

CMD [ "./brother_ql_web.py", "--model", "QL-700", "file:///dev/usb/lp0" ]
