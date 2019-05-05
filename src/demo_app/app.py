import dash

EXTERNAL_STYLESHEETS = [
    {
        'href': "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css",
        'rel': "stylesheet",
        'integrity': "sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T",
        'crossorigin': "anonymous"
    }]

# Dash app setup.
app = dash.Dash(__name__, external_stylesheets=EXTERNAL_STYLESHEETS)
app.title = 'Hawthorne Disturbance Data Exploration'
app.config.suppress_callback_exceptions = True
