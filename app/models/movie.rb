class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :poster_image_url, ImageUploader

  validates :title,
        presence: true

      validates :director,
        presence: true

      validates :runtime_in_minutes,
        numericality: { only_integer: true }

      validates :description,
        presence: true

      # validates :poster_image_url,
      #   presence: true

      validates :release_date,
        presence: true

      validate :release_date_is_in_the_past

      paginates_per 10


       # def self.search_by_title_and_director(title, director)
       #  if filter[:title] || filter[:director]
       #    binding.pry
       #   movies = Movie.where('director == ?', filter[:director], 'title == ?', filter[:title]) 
       #  end
       #  movies
       # end
      # search by runtime

      def self.filter(params)

        if params[:runtime_in_minutes]
          # binding.pry
          movies = Movie.filter_by_runtime(params[:runtime_in_minutes])
        elsif params[:title]   
          movies = Movie.where('title == ?', params[:title])
        elsif params[:director]
          movies = Movie.where('director == ?', params[:director])
        
          

      
              


     
          
              
        #   # movies = Movie.all
        #   @events = @events.where(movie_genre: params[:movie_genre], cuisine: params[:cuisine])
        # movies
        else
          @movies = Movie.all
        end 
      end

      def self.filter_by_runtime(runtime) 
        case runtime
          when 'under_90'
            movies = Movie.where('runtime_in_minutes < ?', 90)
          when 'between_120_and_90'
            movies = Movie.where('runtime_in_minutes < ? AND runtime_in_minutes > ?', 120, 90)
          when 'over_120'
            movies = Movie.where('runtime_in_minutes > ?', 120)
        end
        movies
      end

      def review_average
        reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
      end

      protected

      def release_date_is_in_the_past
        if release_date.present?
          errors.add(:release_date, "should be in the past") if release_date > Date.today
        end
      end

end
