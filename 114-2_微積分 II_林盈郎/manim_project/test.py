from manim import *

# ============================================================
# 在這裡修改你的公式
# func:        r = f(θ) 的函數，用 np.sin / np.cos 等
# theta_range: [起始θ, 結束θ]，用 PI 表示 π
# color:       顏色，如 ORANGE / BLUE / RED / GREEN / YELLOW
# label:       顯示的文字標籤
# ============================================================
CURVES = [
    # {
    #     "label":       "r = csc θ",
    #     "func":        lambda t: 1 / np.sin(t),
    #     "color":       ORANGE,
    #     "theta_range": [PI/4, 3*PI/4],
    # },
    {
        "label":       "r = 2 cos θ",
        "func":        lambda t: 2 * np.cos(t),
        "color":       ORANGE,
        "theta_range": [0, PI],
    },
    # 想加第二條就複製上面這個 {} 貼在這裡
]
# ============================================================


class test(Scene):
    def construct(self):
        polar_plane = PolarPlane(radius_max=3, size=6)
        self.play(FadeIn(polar_plane))
        self.wait(0.3)

        completed_curves = []

        for curve_def in CURVES:
            label_text = curve_def["label"]
            r_func = curve_def["func"]
            color = curve_def["color"]
            theta_start, theta_end = curve_def["theta_range"]

            # --- label ---
            label = Text(
                label_text,
                color=color,
                font_size=36,
            ).to_corner(UL).shift(DOWN * 0.3)
            self.play(FadeIn(label), run_time=0.4)

            # --- ValueTracker ---
            tracker = ValueTracker(theta_start)

            origin = polar_plane.get_origin()

            # --- 掃過區域填色（從原點出發的扇形多邊形）---
            filled_area = always_redraw(
                lambda fn=r_func, t0=theta_start: _make_filled_area(
                    polar_plane, fn, t0, tracker.get_value(), color
                )
            )

            # --- r 向量 ---
            r_line = always_redraw(
                lambda fn=r_func: Line(
                    start=origin,
                    end=polar_plane.polar_to_point(fn(tracker.get_value()), tracker.get_value()),
                    color=color,
                    stroke_width=3,
                )
            )
            dot = always_redraw(
                lambda fn=r_func: Dot(
                    point=polar_plane.polar_to_point(fn(tracker.get_value()), tracker.get_value()),
                    color=color,
                    radius=0.07,
                )
            )

            # --- 動態曲線 ---
            live_curve = VMobject(color=color, stroke_width=4)
            live_curve.set_points_as_corners([origin])

            def make_updater(fn, t_start):
                def updater(mob):
                    t = tracker.get_value()
                    n = max(2, int(abs(t - t_start) / PI * 300))
                    pts = [
                        polar_plane.polar_to_point(fn(s), s)
                        for s in np.linspace(t_start, t, n)
                    ]
                    mob.set_points_smoothly(pts)
                return updater

            updater_fn = make_updater(r_func, theta_start)
            live_curve.add_updater(updater_fn)

            # 填色在最底層，曲線和向量在上面
            self.add(filled_area, live_curve, r_line, dot)

            # --- 播放掃描 ---
            self.play(
                tracker.animate.set_value(theta_end),
                run_time=3,
                rate_func=linear,
            )

            live_curve.remove_updater(updater_fn)
            self.remove(filled_area, r_line, dot, live_curve)

            # --- 保留靜態完成版本 ---
            n_final = 300
            final_pts = [
                polar_plane.polar_to_point(r_func(t), t)
                for t in np.linspace(theta_start, theta_end, n_final)
            ]

            # 靜態填色：曲線點 + 回到原點 = 封閉多邊形
            static_fill = _make_filled_area(polar_plane, r_func, theta_start, theta_end, color)
            static_curve = VMobject(color=color, stroke_width=4)
            static_curve.set_points_smoothly(final_pts)

            self.add(static_fill, static_curve)
            completed_curves.append((static_fill, static_curve))

            self.play(FadeOut(label), run_time=0.3)
            self.wait(0.4)

        self.wait(2)


def _make_filled_area(polar_plane, fn, t_start, t_current, color):
    """建立從原點到曲線再回到原點的填色多邊形"""
    origin = polar_plane.get_origin()
    n = max(2, int(abs(t_current - t_start) / PI * 200))
    curve_pts = [
        polar_plane.polar_to_point(fn(t), t)
        for t in np.linspace(t_start, t_current, n)
    ]
    # 多邊形：原點 → 沿曲線 → 回原點
    all_pts = [origin] + curve_pts + [origin]
    poly = Polygon(*all_pts, color=color, fill_color=color, fill_opacity=0.3, stroke_width=0)
    return poly