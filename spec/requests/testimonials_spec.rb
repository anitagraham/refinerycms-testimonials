# encoding: utf-8
require 'spec_helper'
require 'i18n'

# Use add_testimonial when testing the online interface

module Refinery
  module  Admin

    describe 'Testimonials Admin Interface' do
      login_refinery_user

      context 'At all times' do
        it 'has a Testimonials Tab' do
          visit  refinery.admin_dashboard_path
          expect(page).to have_content(::I18n.t('title', :scope => 'refinery.plugins.refinery_testimonials'))
          expect(page).to have_selector('#plugin_refinery_testimonials')
        end
      end

      context 'When there are no testimonials' do
        it 'Says no items yet' do
          visit refinery.testimonials_admin_testimonials_path
          expect(page).to have_content(::I18n.t('no_items_yet', :scope => 'refinery.testimonials.admin.testimonials.records'))
        end

        it "doesn't show reorder testimonials link" do
          visit refinery.testimonials_admin_testimonials_path

          within '#actions' do
            expect(page).to have_no_content(::I18n.t('reorder', :scope => 'refinery.testimonials.admin.testimonials.actions'))
            expect(page).to have_no_selector("a[href='/refinery/testimonials/testimonials']")
          end
        end
      end

      describe 'action links' do
        it 'shows add new testimonial link' do
          visit refinery.testimonials_admin_testimonials_path

          within '#actions' do
            expect(page).to have_content(::I18n.t('create_new', :scope => 'refinery.testimonials.admin.testimonials.actions'))
            expect(page).to have_selector("a[href='/refinery/testimonials/testimonials/new']")
          end
        end

        context 'when some testimonials exist' do
          before { 2.times { |i| build_testimonial("Testimonial #{i}", 'quote')} }

          it 'shows reorder testimonials link' do
            visit refinery.testimonials_admin_testimonials_path

            within '#actions' do
              expect(page).to have_content(::I18n.t('reorder', :scope => 'refinery.testimonials.admin.testimonials.actions'))
              expect(page).to have_selector("a[href='/refinery/testimonials/testimonials']")
            end
          end
        end
      end

      describe 'new/create', :js => true do
        it 'allows a testimonial to be created' do
          visit refinery.testimonials_admin_testimonials_path
          add_testimonial('My first Testimonial', 'Quote')

          expect(page).to have_content("'Quote by My first Testimonial' was successfully added.")

          expect(page.html).to include('Remove this testimonial forever')
          expect(page.html).to include('Edit this testimonial')
          expect(page.html).to include('/refinery/testimonials/testimonials/1/edit')

          expect(Refinery::Testimonials::Testimonial.count).to eq(1)
        end
      end

      describe 'edit/update' do
        before do
          build_testimonial('Update me', 'quote')

          visit refinery.testimonials_admin_testimonials_path
          expect(page).to have_content('Update me')
        end

        context 'when saving and returning to index' do
          it 'updates testimonial' do
            click_link 'Edit this testimonial'

            fill_in 'Name', :with => 'Updated'
            click_button 'Save'

            expect(page).to have_content("'Quote by Updated' was successfully updated.")
          end
        end
      end

      describe 'Destroy' do
        context 'When a testimonial can be deleted' do
          before do
            build_testimonial('Delete me', 'Quote me')
          end

          it 'Will show delete button' do
            visit refinery.testimonials_admin_testimonials_path
            within '.record' do
              expect(page.html).to include(::I18n.t('delete', :scope => 'refinery.testimonials.admin.testimonials.testimonial'))
              expect(page).to have_selector("a[href='/refinery/testimonials/testimonials/1']")
            end
          end

          it 'Will delete the testimonial' do
            visit refinery.testimonials_admin_testimonials_path
            click_link 'Remove this testimonial forever'

            expect(page).to have_content("'Quote by Delete me' was successfully removed.")
            expect(Refinery::Testimonials::Testimonial.count).to eq(0)
          end
        end
      end

      describe 'Page Controls' do
        before(:all)   do
          create_page('Test Controls')
        end

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
            expect(page.has_unchecked_field?('page_testimonials_show')).to be_true
            expect(page.has_field?('page_testimonials_count', with: '0')).to be_true
            expect(page.has_unchecked_field?('page_testimonials_select_recent')).to be_true
            expect(page.has_checked_field?('page_testimonials_select_random')).to be_true
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