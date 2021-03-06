#include <iostream>
#include <sstream>
#include <opencv2/opencv.hpp>
#include <ctime>

const int N = 36;

std::vector<cv::Rect> parse(std::string const & src)
{
    auto atoi = [](char c) -> int {
        char a[] = { c, 0 };
        return std::stoi(a, nullptr, N);
    };
    std::vector<cv::Rect> rects((src.size() + 1) / 5);
    for (size_t i = 0; i < rects.size(); ++i) {
        int pos = i * 5;
        rects[i].x = atoi(src[pos]);
        rects[i].y = atoi(src[pos + 1]);
        rects[i].width = atoi(src[pos + 2]) - rects[i].x;
        rects[i].height = atoi(src[pos + 3]) - rects[i].y;
    }
    return rects;
}

cv::Mat make_pic(std::vector<cv::Rect> const & rects)
{
    cv::Mat canvas = cv::Mat::zeros(N + 2, N + 2, CV_8UC3);
    for (size_t i = 0; i < rects.size(); ++i) {
        const uint16_t v = 1 << (i + 1);
        const uint8_t a0 = v / 256;
        const uint8_t a1 = v % 256;
        const int right = rects[i].x + rects[i].width;
        const int bottom = rects[i].y + rects[i].height;
        for (int x = rects[i].x + 1; x <= right; ++x) {
            for (int y = rects[i].y + 1; y <= bottom; ++y) {
                auto & v = canvas.at<cv::Vec3b>(y, x);
                v[0] |= a0;
                v[1] |= a1;
            }
        }
    }
    return canvas;
}

std::vector<cv::Rect> search_rect(cv::Mat const & pic)
{
    cv::Mat checked = cv::Mat::zeros(N, N, CV_8UC1);
    std::vector<cv::Rect> dst;
    for (int x = 0; x < pic.cols; ++x) {
        for (int y = 0; y < pic.rows; ++y) {
            if (checked.at<uint8_t>(y, x))
                continue;
            cv::Mat mask = cv::Mat::zeros(pic.rows + 2, pic.cols + 2, CV_8UC1);
            cv::Rect rc;
            floodFill(pic, mask, cv::Point(x, y), cv::Scalar::all(0xFF), &rc);
            mask = mask(cv::Rect(1, 1, N, N));
            if (rc.area() == cv::countNonZero(mask))
                dst.push_back(rc);
            checked += mask;
        }
    }
    return dst;
}

std::vector<int> sort_area(std::vector<cv::Rect> const & rects)
{
    std::vector<int> areas;
    for (auto rc : rects)
        areas.push_back(rc.area());
    std::sort(areas.begin(), areas.end());
    return areas;
}

template<typename container>
std::string join(std::string const & sep, container const & c)
{
    std::stringstream ss;
    for (size_t i = 0; i < c.size(); ++i) {
        ss << c[i];
        if (i < c.size() - 1)
            ss << sep;
    }
    return ss.str();
}

std::string calc(std::string const & src)
{
    return join(",", sort_area(search_rect(make_pic(parse(src)))));
}

void test(std::string const & src, std::string const & exp)
{
    auto const act = calc(src);
    if (act == exp) {
        // std::cerr << "OK" << std::endl;
    } else {
        std::cerr << "NG " << src << " : " << act << " != " << exp << std::endl;
    }
}

int main()
{
    auto start = clock();
    /*0*/ test( "43gw/d7qq/mlop", "8,57" );
    /*1*/ test( "034a", "28" );
    /*2*/ test( "06qr/8pnq", "15" );
    /*3*/ test( "c1th/b2qy", "210" );
    /*4*/ test( "c8wz/gbsg/i0xd", "20" );
    /*5*/ test( "97uv/2g5x/eihv", "39,51" );
    /*6*/ test( "254d/2jvu/mjvu", "16,99,220" );
    /*7*/ test( "ggiu/ggzu/g5ig", "22,28,238" );
    /*8*/ test( "jbnc/i7xe/i7je/icje", "2,4,5" );
    /*9*/ test( "3cey/0fzo", "27,33,99,110,189" );
    /*10*/ test( "00ab/p0zd/0ofz/87rs", "8,12,28" );
    /*11*/ test( "1dsy/2d9s/2s9y", "21,42,105,399" );
    /*12*/ test( "28db/d0lm/d1i8/l0w5", "33,35,55" );
    /*13*/ test( "3aen/4fir/1lev", "2,20,40,48,60" );
    /*14*/ test( "j7ou/3rms/m4vs", "3,10,16,42,60" );
    /*15*/ test( "336a/3rkw/jlor/3akw", "6,21,24,85" );
    /*16*/ test( "21om/87bv/67cv", "9,15,18,27,30,45" );
    /*17*/ test( "4hhx/056u/4rvu", "6,20,33,39,42,110" );
    /*18*/ test( "b0sh/pgxt/88lq/amux", "3,20,35,44,90" );
    /*19*/ test( "c0hc/h6md/fdmk/4cfj", "2,35,49,60,77" );
    /*20*/ test( "0liz/ilvz/0lvr/0rvz", "78,104,108,144" );
    /*21*/ test( "81ib/q1zb/8cir/qczr", "90,100,135,150" );
    /*22*/ test( "h7t8/t8ye/g8he/hetz", "6,12,30,72,252" );
    /*23*/ test( "b5qy/o6qc/21tb/qoyu/b5eu", "2,10,18,48,57" );
    /*24*/ test( "eajn/jkln/j8ua/nkun/u4wy", "6,21,22,60,65" );
    /*25*/ test( "wwzz/nfuw/nfzz/41vw/l1r2/nfrg", "4,6,9,17" );
    /*26*/ test( "46rb/t6xb/m7zk/4hrj/thxj", "4,8,10,16,20,36" );
    /*27*/ test( "olwx/ogul/ogwx/ogux/agux", "10,24,30,72,238" );
    /*28*/ test( "b7un/c3hv/fiyo/h6xm", "2,10,12,13,16,20,52,143" );
    /*29*/ test( "d6qa/o4qr/tcur/9bto", "2,4,6,8,15,26,39,44,195" );
    /*30*/ test( "2lsx/54hf/k3yi/8dhw/bhny", "3,12,18,24,33,60,66" );
    /*31*/ test( "apcx/a8pv/7uwx/a2c8/c8pu", "2,4,9,10,12,13,34,286" );
    /*32*/ test( "7yjz/jywz/7ejz/j5wy/bejz/jewy", "4,8,13,80,117,160,260" );
    /*33*/ test( "d0wk/5dqu/6lqs/77ae/f4mq/56bm", "3,4,5,7,14,18,28,35,49,63" );
    /*34*/ test( "d4gn/94in/d4rs/94xu/97xn", "6,9,12,18,27,32,48,64,70,96,144" );
    /*35*/ test( "l5wh/wdxn/60xs/c5fd/jpwx/mgqx", "4,9,10,12,15,18,20,24,30,32" );
    /*36*/ test( "5178/58xk/uixk/71u8/71uk/71ui/51ui", "4,6,14,20,30,46,161,230" );
    /*37*/ test( "m8sp/mosp/2imp/i8sp/2isp/i8si/misp/iosp", "4,6,24,36,40,60,112" );
    /*38*/ test( "34d5/253k/f4m5/m5rk/2o3u/3udy/fumy/moru", "6,7,10,15,28,30,40,75" );
    /*39*/ test( "2ilw/mbnc/n9wj/9dmy/6qwy/2ekh/9dkh", "1,6,11,18,21,33,72,80,90,96" );
    /*40*/ test( "j0le/10uo/q6ue/jeqt/jelf/l6xf", "2,4,5,27,28,32,35,36,40,54,63,432" );
    /*41*/ test( "j4mu/31r5/qeyf/0f5h/r0v5/00qi/j5kf/jlru", "3,4,8,9,10,10,20,27,45,52" );
    /*42*/ test( "g8kc/dbuv/gbkc/dbgv/evuw/dbui/d8kw", "1,4,6,9,10,12,21,24,39,52,70,130" );
    /*43*/ test( "apry/a0ry/a0hx/60hp/6xhy/a0hp/a0hy/6phy/6phx", "4,7,32,56,90,100,175,250" );
    /*44*/ test( "1eok/33by/d0kz/1rnw", "10,10,12,12,14,15,16,21,24,35,40,42,48,49,56,88,98" );
    /*45*/ test( "0qbs/6cws/l6xj/659q/03lc/bclp/96dj/96wc", "10,12,13,14,14,21,24,42,48,66,77" );
    /*46*/ test( "q8sr/98yu/clyn/s8yl/9lqr/0rsu/0l9m/0n9u", "4,8,9,12,26,27,28,36,42,57,78,221" );
    /*47*/ test( "5sjy/jbsy/8dgp/gkvp/gdvh/jhvp/i2vk", "3,4,6,8,9,12,15,15,18,27,36,45,81,84,96" );
    /*48*/ test( "42va/10nf/23l6/c2uw/3hpo/4ofu/m7sv", "3,5,6,8,8,15,18,20,21,24,27,32,48,50,63,70" );
    /*49*/ test( "84lj/10j1/wcxd/ljnl/1njx/01xd/00x1/81wq/1c8q", "1,1,4,7,11,14,18,21,33,70,78,117,126" );
    /*50*/ test( "kfvg/76vq/136d/6gvq/6g7q/137g/7dmz/63m6/m3vz", "2,3,9,10,27,45,50,81,81,90,105,135,150" );
    /*51*/ test( "4eht/38jt/jeym/htjv/eeyv/eejt/3myv/h1jt/hejm", "4,6,7,12,14,14,16,21,22,24,70,80,120,135" );
    /*52*/ test( "smuz/04c7/28zc/83ri/cihu/8flm/masw/8ivo", "2,4,6,8,10,10,12,16,16,20,22,24,24,30,30,36,39,48" );
    /*53*/ test( "7fuu/17fd/6cpg/fghu/ahnt/adww/rhxz/4hxl/0pby", "1,2,2,2,3,3,4,4,4,5,8,8,9,10,12,12,12,12,15,15,16,16,20,24,27,30,32,48" );
    std::cout << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "sec" << std::endl;
}