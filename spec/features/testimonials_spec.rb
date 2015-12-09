# encoding: utf-8
require 'spec_helper'
require 'i18n'

module Refinery
  module Testimonials
    module  Admin

      describe 'Testimonials Tab', type: :feature do
        refinery_login_with :refinery_user
        include_context 'Testimonials Tab'

        it_has_behaviour 'Testimonials Tab Available'

        context 'When there are no testimonials' do
          include_context 'No Testimonials'
          it_has_behaviour 'No Testimonials Shown'
          it_has_behaviour 'Allows a testimonial to be added'
        end

        context 'when some testimonials exist' do
          include_context 'Many Testimonials'
          it_behaves_like 'an index'
          it_has_behaviour 'Allows a testimonial to be added'
          it_has_behaviour 'Allows a testimonial to be deleted'
          it_has_behaviour 'Allows a testimonial to be edited'
        end
      end    #describe Testimonials Tab

      describe 'Page Controls' do
        include_context 'Edit Page'

        before(:each) do
          visit refinery.admin_pages_path
          find(:linkhref, '/refinery/pages/test-controls/edit').click
        end

        it 'Shows the testimonials tab' do
          within '#custom_testimonials_tab' do
            expect(page).to have_content('Testimonials')
          end
        end
        it 'should have a page part for controlling testimonial display' do
          expect(page.html).to have_selector('#page_testimonial_control')
        end

        context 'Default Testimonial Settings' do
          it 'has the default testimonial controls displayed' do
            expect(page.has_unchecked_field?('page_testimonials_show')).to be true
            expect(page.has_field?('page_testimonials_count', with: '0')).to be true
            expect(page.has_unchecked_field?('page_testimonials_select_recent')).to be true
            expect(page.has_checked_field?('page_testimonials_select_random')).to be true
          end
        end

        context 'Editing Testimonial Settings' do
          it 'Can change whether testimonials are changed on this page' do
            page.check 'page_testimonials_show'
            click_button 'Save & continue editing'
            find('#flash').visible?
            expect(page).to have_content("'Test Controls' was successfully updated.")
            expect(page.has_checked_field?('page_testimonials_show'))
          end

          it 'Can change how many testimonials are shown on a page' do
            page.fill_in('page_testimonials_count', with: '10')
            click_button 'Save'
            visit refinery.admin_pages_path
            find(:linkhref, '/refinery/pages/test-controls/edit').click
            expect(page).to have_field('page_testimonials_count', with: '10')
          end

          it 'Can change the way testimonials are selected for display' do
            page.choose('page_testimonials_select_recent')
            click_button 'Save'
            visit refinery.admin_pages_path
            find(:linkhref, '/refinery/pages/test-controls/edit').click
            expect(page.has_checked_field?('page_testimonials_select_recent'))
            expect(page.has_unchecked_field?('page_testimonials_select_random'))
          end
        end
      end
    end
  end
end