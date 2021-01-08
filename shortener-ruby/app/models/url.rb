IS_URL = %r{\A(https?|ftp|file)://.+\Z}
# copy/paste from oreily's regex cookbook... validating urls is hard.

class Url < ApplicationRecord
  validates :shortLink, length: { is: 6 }, uniqueness: true, presence: true
  validates :originalLink, format: { with: IS_URL }, uniqueness: true, presence: true
end
