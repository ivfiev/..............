from kitty.fast_data_types import get_boss


def draw_title(data):
    base = f"{data['index']} {data['title']}"
    if data["num_windows"] <= 1:
        return base
    try:
        tab = get_boss().tab_for_id(data["tab"].tab_id)
        win_id = 1 + list(tab).index(tab.active_window)
        return f"{base} ({win_id}/{data['num_windows']})"
    except Exception:
        return f"{base} ({data['num_windows']})"
