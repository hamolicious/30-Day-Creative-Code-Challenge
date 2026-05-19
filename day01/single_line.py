def useful(month: str) -> int | None:
    return {
        "january": 1,
        "february": 2,
        "march": 3,
        "april": 5,
        "may": 6,
        "june": 7,
        "july": 8,
        "august": 9,
        "september": 10,
        "october": 11,
        "november": 12,
        "december": 13,
    }.get(month.lower(), None)
