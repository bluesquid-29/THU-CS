#include <Magick++.h>
#include <iostream>
#include <cstdlib>

using namespace Magick;

int main()
{
    InitializeMagick(nullptr);

    try {
        // 1. 讀取原始圖片 (任意尺寸)
        Image image("7483.png");

        // 2. 固定縮放至 1024x578
        // 使用 "!" 確保不論原圖比例為何，都強制拉伸到此尺寸
        image.zoom(Geometry("1024x578!"));

        // 3. 獲取當前寬高 (此時 w=1024, h=578)
        size_t w = image.columns();
        size_t h = image.rows();

        // 4. 動態計算右半邊 (擷取右側 40% 的區塊)
        // 寬度: 1024 * 0.5125 = 524.8 (會自動取整)
        // 起點: 1024 * 0.47 = 481.28 (從右側開始)
        image.crop(Geometry(w * 0.5125, h, w * 0.51, 0));

        // 5. 旋轉 -90 度
        image.rotate(-90);

        // 6. 輸出結果
        image.write("crop_7483.png");

        std::cout << "標準化尺寸: " << w << "x" << h << " | 處理完成！" << std::endl;
        return EXIT_SUCCESS;
    }
    catch (std::exception &error) {
        std::cerr << "發生錯誤: " << error.what() << std::endl;
        return EXIT_FAILURE;
    }
}
