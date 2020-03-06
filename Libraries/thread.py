import threading


from robot.api.deco import keyword

"""Custom library"""
__all__ = ['run_in_thread']


@keyword('Run in separate thread')
def run_in_thread(fn, *k, **kw):
    def run():
        t = threading.Thread(target=fn, args=k, kwargs=kw)
        t.start()
        return t  # <-- this is new!

    return run


@keyword('Fast run')
def fast_run(fn, **kw):
    return threading.Thread(target=exec, kwargs=kw)
