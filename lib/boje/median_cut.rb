module Boje
    class MedianCut
        SplitInfo = Struct.new(:range, :group_index, :color_index, keyword_init: true)
        def self.process(colors, count, hist)
            colors = colors.uniq # Remove duplicate colors
            groups = [colors]
            limit = [count, colors.size].min
            
            loop do
                split_info = determine_split(groups)
                group1, group2 = split_group(groups[split_info.group_index], split_info)
                groups.delete_at(split_info.group_index) # Remove group that we split by
                groups.insert(split_info.group_index, group2) unless group2.empty? # MOZE APPEND UMJESTO SORT
                groups.insert(split_info.group_index, group1) unless group1.empty?
    
                break if groups.size >= limit
            end
            
            palette = []
            groups.sort_by! { |group| -calc_sort_score(group, hist) }
            groups.each do |group|
                palette << average_color(group)
            end
    
            palette[0...count]
        end
    
        private
    
        def self.determine_split(groups)
            stats = []
    
            groups.each_with_index do |group, index|
                reds = group.map { |el| el[0] }
                greens = group.map { |el| el[1] }
                blues = group.map { |el| el[2] }
    
                ranges = []
                ranges << SplitInfo.new(group_index: index, range: reds.max - reds.min, color_index: 0)
                ranges << SplitInfo.new(group_index: index, range: greens.max - greens.min, color_index: 1)
                ranges << SplitInfo.new(group_index: index, range: blues.max - blues.min, color_index: 2)
    
                stats << ranges.max_by(&:range)
            end
    
            stats.max_by(&:range)
        end
    
        def self.split_group(group, split_info)
            colors = group.sort_by { |pixel| pixel[split_info.color_index] }
    
            median_index = colors.size / 2
    
            group1 = colors[0..(median_index - 1)]
            group2 = colors[median_index..-1]
    
            [group1, group2]
        end

        def self.calc_sort_score(group, hist)
            score = 0
            group.each do |pixel|
                score += hist[Boje.get_pixel_index(pixel)]
            end

            score
        end
    
        def self.average_color(colors)
            average_r = 0
            average_g = 0
            average_b = 0
    
            colors.each do |color|
                average_r += color[0]
                average_g += color[1]
                average_b += color[2]
            end
            average_r = (average_r / colors.length).round()
            average_g = (average_g / colors.length).round()
            average_b = (average_b / colors.length).round()
    
            [average_r, average_g, average_b]
        end
    end
end