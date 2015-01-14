require "spec_helper"

def set_settings(settings)
  defaults ||= {
    testimonials_show: false,
    testimonials_count: 0,
    testimonials_select: 'Recent'
  }
  settings = settings.merge(defaults)
  test_page = Refinery::Page.by_title('Test Controls').first
    test_page.testimonials_show = settings["testimonials_show"]
    test_page.testimonials_count = settings["testimonials_count"]
    test_page.testimonials_select = settings["testimonials_select"]
  test_page.save

end

module Refinery

  describe PagesController, :type => :feature do
    refinery_login_with :refinery_user

    let(:test_page) { FactoryGirl.create(:page, title: 'Test Controls') }
    FactoryGirl.create_list(:testimonial, 8)

    context 'With default settings' do

      it 'should not get any testimonials' do
        set_settings(settings)
        get :show, path: 'test_controls'
        expect(assigns(:testimonials)).to be_nil
      end
    end

    context 'Testimonials_show=true ' do
      let(:settings) {{
        testimonials_show: true,
        testimonials_count: 0,
        testimonials_select: 'Recent'}
      }

      describe 'Default the number of testimonials to show=0' do
        context 'testimonials_count=0' do
          it 'should return all testimonials' do
            set_settings(settings)
            get :show, path: 'test_controls'
            expect(assigns(:testimonials).size).to eq(Refinery::Testimonials.all.count)
          end
        end

        context 'testimonials_count=4' do
          it 'should return four testimonials' do
            settings["testimonials_count"] = 4
            set_settings(settings)
            get :show, path: 'test_controls'
            expect(assigns(:testimonials).size).to eq 4
          end
        end
      end

      describe "Change the order of testimonials returned"
        context 'Show testimonials in recent order' do

          it 'should return testimonials with most recent first' do
            set_settings(settings)
            get :show, path: 'test_controls'
            expect(assigns(:testimonials)).to be_ordered_by('received_date_desc')
          end
        end

        context 'Show testimonials in random order' do
          it 'should return testimonials in random order' do
            settings["testimonials_select"]='Random'
            set_settings(settings)
            get :show, path: 'test_controls'
            expect(assigns(:testimonials)).not_to be_ordered_by('received_date_desc')
          end
       end
    end
  end
end
