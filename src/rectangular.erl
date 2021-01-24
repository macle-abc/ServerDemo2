-module(rectangular).
-author("macle").

-record(point, {x = 0, y = 0}).
-record(rectangular_place, {lt = #point{}, rt = #point{}, ld = #point{}, rd = #point{}}).
-export([judge_two_rectangular_intersection/2, test/0]).

%% 即选择两个矩形中的左上角的点坐标的最大值(LeftTopPoint)
%% 及其右下角的点坐标的最小值(RightDownPoint)
%% 当LeftTopPoint位于RightDownPoint的左上方或者重合的时候则两个矩形相交或者包含（即技能击中Boss）
judge_two_rectangular_intersection(#rectangular_place{lt = LtOne = #point{},
    rt = #point{},
    ld = #point{},
    rd = RdOne = #point{}},
    #rectangular_place{lt = LtTwo = #point{},
        rt = #point{},
        ld = #point{},
        rd = RdTwo = #point{}}) ->
    LeftTopPoint = #point{x = lists:max([LtOne#point.x, LtTwo#point.x]),
        y = lists:max([LtOne#point.y, LtTwo#point.y])},
    RightDownPoint = #point{x = lists:min([RdOne#point.x, RdTwo#point.x]),
        y = lists:min([RdOne#point.y, RdTwo#point.y])},
    LeftTopPoint#point.x =< RightDownPoint#point.x andalso LeftTopPoint#point.y =< RightDownPoint#point.y;
judge_two_rectangular_intersection(_, _) -> false.

test() ->
    A1 = #rectangular_place{lt = #point{x = 0, y = 0}, rt = #point{x = 0, y = 1},
        ld = #point{x = 1, y = 0}, rd = #point{x = 1, y = 1}},
    B1 = #rectangular_place{lt = #point{x = 1, y = 1}, rt = #point{x = 2, y = 1},
        ld = #point{x = 1, y = 3}, rd = #point{x = 2, y = 3}},
    true = judge_two_rectangular_intersection(A1, B1),

    A2 = #rectangular_place{lt = #point{x = 1, y = 1}, rt = #point{x = 6, y = 1},
        ld = #point{x = 1, y = 4}, rd = #point{x = 6, y = 4}},
    B2 = #rectangular_place{lt = #point{x = 2, y = 2}, rt = #point{x = 3, y = 2},
        ld = #point{x = 2, y = 3}, rd = #point{x = 3, y = 3}},
    true = judge_two_rectangular_intersection(A2, B2),

    A3 = #rectangular_place{lt = #point{x = 1, y = 1}, rt = #point{x = 6, y = 1},
        ld = #point{x = 1, y = 4}, rd = #point{x = 6, y = 4}},
    B3 = #rectangular_place{lt = #point{x = 3, y = 2}, rt = #point{x = 7, y = 2},
        ld = #point{x = 3, y = 3}, rd = #point{x = 7, y = 3}},
    true = judge_two_rectangular_intersection(A3, B3),

    A4 = #rectangular_place{lt = #point{x = 1, y = 1}, rt = #point{x = 6, y = 1},
        ld = #point{x = 1, y = 4}, rd = #point{x = 6, y = 4}},
    B4 = #rectangular_place{lt = #point{x = 5, y = 2}, rt = #point{x = 7, y = 2},
        ld = #point{x = 5, y = 5}, rd = #point{x = 7, y = 5}},
    true = judge_two_rectangular_intersection(A4, B4),

    A5 = #rectangular_place{lt = #point{x = 3, y = 1}, rt = #point{x = 5, y = 1},
        ld = #point{x = 3, y = 2}, rd = #point{x = 5, y = 2}},
    B5 = #rectangular_place{lt = #point{x = 0, y = 5}, rt = #point{x = 4, y = 5},
        ld = #point{x = 0, y = 6}, rd = #point{x = 4, y = 6}},
    false = judge_two_rectangular_intersection(A5, B5),
    ok.