# --------------------------Area Information----------------------------
STATES = ['Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Delhi',\
          'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand',\
          'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', \
          'Mizoram', 'Nagaland', 'Orissa', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu',\
          'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal' ]
COUNTRY = ['India']
AREA_STATUS_ACTIVE = 'active'
AREA_STATUS_INACTIVE = 'inactive'

DELIVERY_ZONE_STATUS_ACTIVE = 'active'
DELIVERY_ZONE_STATUS_INACTIVE = 'inactive'

HIGH_DELIVERY_CHARGE_PERCENTAGE = 15      #TODO: confirm with management team 
LOW_DELIVERY_CHARGE_PERCENTAGE = 12

CITY_STATUS_ACTIVE = 'active'
CITY_STATUS_INACTIVE = 'inactive'

DEFAULT_SEARCH_CITY_NAME = 'pune'

# --------------------------Kitchen----------------------------
KITCHEN_STATUS_OPEN = 'open'
KITCHEN_STATUS_CLOSE = 'close'

KITCHEN_STATUS_NEW = 'new'
KITCHEN_STATUS_APPROVED = 'approved'
KITCHEN_STATUS_REJECTED = 'rejected'
KITCHEN_STATUS_ACTIVATED = 'activated'
KITCHEN_STATUS_SUSPENDED = 'suspended'

KITCHEN_BUTTON_APPROVE = 'Approve'
KITCHEN_BUTTON_ACTIVATE = 'Activate'
KITCHEN_BUTTON_REJECT = 'Reject'
KITCHEN_BUTTON_SUSPEND = 'Suspend'
KITCHEN_BUTTON_SUBMIT = 'Submit'

# --------------------------Payment Preference----------------------------
PAYMENT_PREFERENCE_COD = 'cash on delivery'
PAYMENT_PREFERENCE_ONLINE = 'online'
PAYMENT_PREFERENCE_CHEQUE = 'cheque'
PAYMENT_PREFERENCE = {
  PAYMENT_PREFERENCE_COD => 'Cash On Delivery', PAYMENT_PREFERENCE_ONLINE => 'Online', PAYMENT_PREFERENCE_CHEQUE => 'Cheque'
}

# --------------------------User----------------------------
DEFAULT_GALLERY_NAME = 'default'

# --------------------------User----------------------------
USER_TYPE_KITCHEN = 'kitchen'
USER_TYPE_EMPLOYEE = 'employee'
USER_TYPE_CUSTOMER = 'customer'

USER_STATUS_ACTIVE = 'active'
USER_STATUS_INACTIVE = 'inactive'
USER_STATUS = {
  USER_STATUS_INACTIVE => 'inactive',
  USER_STATUS_ACTIVE => 'active'
}

# --------------------------User's General Information----------------------------
GENDER_MALE = 'male'
GENDER_FEMALE = 'female'
GENDER = {
  GENDER_MALE => 'Male',
  GENDER_FEMALE => 'Female'
}
MARITAL_STATUS_SINGLE = 'single'
MARITAL_STATUS_MARRIED = 'married'
MARITAL_STATUS = {
  MARITAL_STATUS_SINGLE => 'Single',
  MARITAL_STATUS_MARRIED => 'Married'
}


# --------------------------Emails and REGEX----------------------------
EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
PASSWORD_REGEX = /(?=.*\d)(?=.*[a-zA-Z]).{6,}/

SUPPORT_EMAIL = 'RasoiClub-Support <support@rasoiclub.com>'
MARKETING_EMAIL = 'RasoiClub-Marketing <marketing@rasoiclub.com>'
OPERATIONS_EMAIL = 'RasoiClub-Operations <operations@rasoiclub.com>'
MANAGEMENT_EMAIL = 'RasoiClub-Management <management@rasoiclub.com>'
DELIVERY_EMAIL = 'RasoiClub-Delivery <delivery@rasoiclub.com>'
CONTACT_EMAIL = 'RasoiClub-Contact <contact@rasoiclub.com>'

DEVELOPER_EMAILS = 'RasoiClub-Developer Team <rajul@rasoiclub.com>'
TESTER_EMAILS = 'RasoiClub-Tester Team <shital@rasoiclub.com>'

# --------------------------RC Team----------------------------
TEAM_TYPE_ACCOUNT = 'account'         
TEAM_TYPE_ADMIN = 'admin'
TEAM_TYPE_OPERATION = 'operation'
TEAM_TYPE_VENDOR = 'vendor'
TEAM_TYPE_MANAGEMENT = 'management'

# --------------------------Packaging----------------------------
PACKAGING_PRICE_DEFAULT = 0.0



#------------------------------Meals------------------------------
MEAL_STATUS_ACTIVE = 'active'
MEAL_STATUS_INACTIVE = 'inactive'
MEAL_STATUS = {
  MEAL_STATUS_ACTIVE => 'Active',
  MEAL_STATUS_INACTIVE => 'Inactive'
}
VEG_MEAL = "Veg"
NON_VEG_MEAL = "Non-Veg"
VEG_NONVEG = {
  VEG_MEAL => true,
  NON_VEG_MEAL => false  
}
#-------------------------------SPICEY LEVEL----------------------
SPICY_LEVEL = ['Medium', 'High', 'Low', 'NA']
CUISINE = ['Gujrati', 'North Indian', 'Maharashtrian', 'South Indian', 'Punjabi', 'Bengali', 'Indian', 
          'Italian', 'Chinese', 'Continental', 'Rajasthani', 'Mughlai', 'Mexican']
          
VEG = 'vegetarian'
NON_VEG = 'non_vegetarian'          
          
#------------------------------Menu------------------------------
MENU_NAME_DINNER = 'dinner'
MENU_NAME_PARTY = 'party'
MENU_NAME_TREAT = 'rasoi club treat'

MENU_DINNER_LOWER_LIMIT = 1
MENU_DINNER_UPPER_LIMIT = 8

MENU_PARTY_DEFAULT_LOWER_LIMIT = 10
MENU_PARTY_DEFAULT_UPPER_LIMIT = 15
# --------------------------Search----------------------------
SEARCH_BOX_PLACEHOLDER = "Type Dish Name/ Rasoi Club Kitchen Name/ Area"          

#---------------------------Order----------------------------------

ORDER_STATUS_NEW = 'New'
ORDER_STATUS_OPEN = 'Open'
ORDER_STATUS_CLOSED = 'Closed'
ORDER_STATUS_CANCELED = 'Canceled'
ORDER_STATUS_SETTLED = 'Settled'
ORDER_STATUS_PARTIALLY_SETTLED = 'Partially Settled'

PARTY_PICKUP_HRS = 2

#---------------------------Payment Details----------------------------------
PAYMENT_METHOD_COD = 'COD'

#---------------------------standard Category------------------------
STANDARD_MEAL_CATEGORY = 'standard'

#--------------------------Delivery Time------------------------
DELIVERY_TIMES = {
  '10 AM' => 10,
  '11 AM' => 11,
  '12 PM' => 12,
  '01 PM' => 13,
  '02 PM' => 14,
  '03 PM' => 15,
  '04 PM' => 16,
  '05 PM' => 17,
  '06 PM' => 18,
  '07 PM' => 19,
  '08 PM' => 20,
  '09 PM' => 21
}

#----------------------------Some special constant--------------------
ALL = 'all'
DEFAULT_SERVING_SIZE = 'Per person'
REFINE_SEARCH_COMMIT_BUTTON = 'Refine Search'

#----------------------------Default Kitchen Cut-off hours------------
DEFAULT_DINNER_CUT_OFF_HOUR = 2
DEFAULT_PARTY_CUT_OFF_HOUR = 24
DEFAULT_RC_TREAT_CUT_OFF_HOUR = 48
#--------------------------------Sub Menus And Categories--------------
QUICK_BITE = "quick bite"
TUMMY_FULL = "tummy full" 
EXTRAVAGANZA = "extravaganza"
LIGHT_COMBO = "light combo" 
DESSERT_COMBO = "dessert combo"
STARTER_COMBO = "starter combo"
STARTER_DHAMAKA = "starter dhamaka" 
FAMILY_FEAST = "family feast" 
TRADITIONAL_FEST = "traditional fest" 
SWEET_DELIGHT = "sweet delight"
SNACKS_MUNCH =  "snacks munch"
 
DINNER_AT_DESK = "dinner at desk" 
MY_NUTRITIONAL_NEEDS_VERIFIED = "my nutritional needs verified" 
KITTY_PARTY = "kitty party"
BIRTHDAY_PARTY = "birthday party" 
ANNIVERSARY = "anniversary"
FAMILY_GET_TOGETHER = "family get together" 
FORMAL_CORPORATE_PARTY = "formal / corporate party" 
WEEKEND_PARTY = "weekend party"
 

