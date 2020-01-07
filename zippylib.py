from bs4 import BeautifulSoup
from py_mini_racer import py_mini_racer
from urllib.parse import urlparse

def find_dlbutton(html):
    fullpage = BeautifulSoup(html, "html.parser")
    dl = fullpage.find("dlbutton");
    for e in fullpage.find_all("script", type="text/javascript"):
        if "dlbutton" in (e.text):
            line = e.text.split(";")
            for l in line:
                if "dlbutton" in l:
                    l = l.split("=")[1]
                    ctx = py_mini_racer.MiniRacer()
                    print (ctx.eval(l))

def get_host(html):
    parsed_uri = urlparse(html)
    result = "{uri.scheme}://{uri.netloc}".format(uri=parsed_uri)
    print (result)

if __name__ == "__main__":
    import sys;
    html=sys.stdin.read();
    find_dlbutton(html)
