#include <stdio.h>
#include <string.h>

void swap(char * a, char * b)
{
    char t = *a;
    *a = *b;
    *b = t;
}

void calc(const char * src, char * act)
{
    char a[] = "123456789";
    for(const char * ch = src; *ch; ++ch) {
        int i = (*ch - 'a') % 3;
        char *c1, *c2, *c3;
        if(*ch <= 'c') { // abc
            c1 = a + i * 3;
            c2 = c1 + 1;
            c3 = c2 + 1;
        } else if(*ch <= 'f') { // def
            c1 = a + i + 6;
            c2 = c1 - 3;
            c3 = c2 - 3;
        } else if(*ch <= 'i') { // ghi
            c1 = a + (2 - i) * 3 + 2;
            c2 = c1 - 1;
            c3 = c2 - 1;
        } else if(*ch <= 'l') { //jkl
            c1 = a + (2 - i);
            c2 = c1 + 3;
            c3 = c2 + 3;
        }
        swap(c1, c2);
        swap(c2, c3);
    }
    act[3] = act[7] = '/';
    memcpy(act, a, 3);
    memcpy(act + 4, a + 3, 3);
    memcpy(act + 8, a + 6, 3);
}

void test(const char * src, const char * exp)
{
    char act[12] = { 0 };
    calc(src, act);
    if(strcmp(exp, act)) {
        printf("%s != %s (%s)\n", exp, act, src);
    }
}

int main()
{
    /*0*/ test( "aegj", "286/435/971" );
    /*1*/ test( "a", "231/456/789" );
    /*2*/ test( "e", "183/426/759" );
    /*3*/ test( "g", "123/456/978" );
    /*4*/ test( "j", "126/459/783" );
    /*5*/ test( "bb", "123/645/789" );
    /*6*/ test( "jjj", "123/456/789" );
    /*7*/ test( "bd", "723/164/589" );
    /*8*/ test( "ah", "231/645/789" );
    /*9*/ test( "bj", "124/569/783" );
    /*10*/ test( "db", "723/561/489" );
    /*11*/ test( "dh", "723/615/489" );
    /*12*/ test( "dl", "123/456/789" );
    /*13*/ test( "hc", "123/645/897" );
    /*14*/ test( "gf", "128/453/976" );
    /*15*/ test( "hl", "623/745/189" );
    /*16*/ test( "ja", "261/459/783" );
    /*17*/ test( "ld", "123/456/789" );
    /*18*/ test( "ki", "315/486/729" );
    /*19*/ test( "lfa", "294/753/186" );
    /*20*/ test( "kga", "531/486/972" );
    /*21*/ test( "dbi", "372/561/489" );
    /*22*/ test( "che", "193/625/847" );
    /*23*/ test( "iea", "823/416/759" );
    /*24*/ test( "gbl", "523/964/178" );
    /*25*/ test( "egj", "186/425/973" );
    /*26*/ test( "jcf", "127/456/839" );
    /*27*/ test( "djh", "726/915/483" );
    /*28*/ test( "hld", "123/645/789" );
    /*29*/ test( "leeh", "453/678/129" );
    /*30*/ test( "heja", "851/629/743" );
    /*31*/ test( "cakh", "251/649/837" );
    /*32*/ test( "bhjik", "652/489/713" );
    /*33*/ test( "eabji", "483/269/751" );
    /*34*/ test( "cdbch", "823/156/974" );
    /*35*/ test( "ckgajc", "536/492/817" );
    /*36*/ test( "ggchha", "231/564/978" );
    /*37*/ test( "gfbkeg", "128/534/697" );
    /*38*/ test( "agfbcbf", "239/148/765" );
    /*39*/ test( "ekahijf", "123/645/789" );
    /*40*/ test( "hajdjbe", "789/432/615" );
    /*41*/ test( "elgililj", "976/325/814" );
    /*42*/ test( "chffefif", "317/629/845" );
    /*43*/ test( "ilbbihak", "462/587/319" );
    /*44*/ test( "abcdefghijkl", "123/456/789" );
    /*45*/ test( "hkijbglfaced", "768/125/493" );
    /*46*/ test( "dfkbjiechlga", "256/387/419" );
    /*47*/ test( "hgfkbidlajce", "186/745/239" );
    /*48*/ test( "baciefjhgkdl", "153/482/796" );
}
