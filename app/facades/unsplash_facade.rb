class UnsplashFacade
  def get_image(location)
    resp = UnsplashService.new.get_image(location)
    Image.new(resp)
  end
end
