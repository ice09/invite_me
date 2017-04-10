from bottle import response, static_file, route

def allow_cors(func):
    """ this is a decorator which enable CORS for specified endpoint """
    def wrapper(*args, **kwargs):
        response.headers['Access-Control-Allow-Origin'] = '*' # * in case you want to be accessed via any website
        return func(*args, **kwargs)
    return wrapper
    
@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='./static/')
