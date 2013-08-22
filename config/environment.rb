# Load the rails application
require File.expand_path('../application', __FILE__)

ENV['RECAPTCHA_PUBLIC_KEY'] = '6Leh8-ESAAAAAOi0akP6Ptdu-dUwGFU6629U8rwj'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6Leh8-ESAAAAAJnPfFl6xiR-hh-fKPzoji_juNIJ'
# Initialize the rails application
RasoiclubCom::Application.initialize!
