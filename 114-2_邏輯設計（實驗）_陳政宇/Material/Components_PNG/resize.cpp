#include <Magick++.h>
#include <iostream>
#include <cstdlib>

using namespace Magick;

int main()
{
    InitializeMagick(nullptr);

    try {
        // 1. 讀取原始圖片 (任意尺寸)
        Image image("74LS83.png");

        // 2. 固定縮放至 1024x578
        // 使用 "!" 確保不論原圖比例為何，都強制拉伸到此尺寸
        image.zoom(Geometry("760x450!"));

        // 3. 輸出結果
        image.write("resize_74LS83.png");

        // std::cout << "標準化尺寸: " << w << "x" << h << " | 處理完成！" << std::endl;
        std::cout << "強制圖形 size 完成！";
        return EXIT_SUCCESS;
    }
    catch (std::exception &error) {
        std::cerr << "發生錯誤: " << error.what() << std::endl;
        return EXIT_FAILURE;
    }
}